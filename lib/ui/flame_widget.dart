import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:space_balls/business/user_bloc.dart';
import 'package:space_balls/game/space_balls_game.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/ui/game_page.dart';
import 'package:space_balls/ui/preview_painter.dart';

import '../business/game_bloc.dart';

final _log = Logger('FlameWidget');

class FlameWidget extends StatefulWidget {
  final GameLevel level;
  final int levelId;

  const FlameWidget({
    Key? key,
    required this.level,
    required this.levelId,
  }) : super(key: key);

  @override
  State<FlameWidget> createState() => _FlameWidgetState();
}

class _FlameWidgetState extends State<FlameWidget> {
  late final game = SpaceBallsGame(
    level: widget.level,
    onWin: () {
      final userBloc = context.read<UserBloc>();
      final user = userBloc.state.user;

      if (user == null) return;

      final updatedUser = user.copyWith(
        levelsCompleted: {
          ...user.levelsCompleted,
          widget.levelId,
        },
      );

      userBloc.add(UpdateUser(updatedUser));
    },
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return GestureDetector(
          onPanStart: (details) {
            _log.fine(
                'onPanStart: ${details.localPosition.dx} ${details.localPosition.dy}');
            context.read<GameBloc>().add(
                  StartPreview(details.localPosition),
                );
          },
          onPanUpdate: (details) {
            _log.fine(
                'onPanUpdate: ${details.localPosition.dx} ${details.localPosition.dy}');
            context.read<GameBloc>().add(
                  PreviewShot(details.localPosition),
                );
          },
          onPanEnd: (details) {
            context.read<GameBloc>().add(
                  Shoot(),
                );
            if (state.previewOffset != null) {
              final player = game.level.gameObjects.firstWhere(
                (element) => element is PlayerBall,
              ) as PlayerBall;
              final x = state.previewOffset!.dx - state.previewStart!.dx;
              final y = state.previewOffset!.dy - state.previewStart!.dy;
              game.shoot(Vector2(x, y));
            } else {
              _log.severe('onPanEnd: previewOffset is null');
            }
          },
          child: Container(
            color: const Color(0xFF2D2D2D),
            child: Stack(
              children: [
                SafeArea(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 3,
                        height: 3.0 * 16.0 / 9.0,
                        child: GameWidget(game: game),
                      ),
                    ),
                  ),
                ),
                if (state.previewOffset != null)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: _previewPainter(context, state),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        FloatingActionButton(
                          heroTag: 'back',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          tooltip: 'Back',
                          backgroundColor: Colors.deepOrange,
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        FloatingActionButton(
                          heroTag: 'reset',
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GamePage(
                                    levelId: widget.levelId,
                                  ),
                                ));
                          },
                          tooltip: 'Reset',
                          backgroundColor: Colors.blue,
                          child: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        FloatingActionButton(
                          heroTag: 'pause',
                          onPressed: () {
                            if (game.paused) {
                              setState(() {
                                game.paused = false;
                              });
                            } else {
                              setState(() {
                                game.paused = true;
                              });
                            }
                          },
                          tooltip: 'pause',
                          backgroundColor:
                              !game.paused ? Colors.red : Colors.green,
                          child: Icon(
                            !game.paused ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),

                        const Spacer(), // Add this to fill remaining space
                        BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                            final user = state.user;
                            if (user != null &&
                                user.levelsCompleted.contains(widget.levelId)) {
                              return const Icon(
                                Icons.check,
                                color: Colors.green,
                                size: 36,
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  CustomPaint _previewPainter(BuildContext context, GameState state) {
    final playerBall = state.level.gameObjects.firstWhere(
      (element) => element is PlayerBall,
    ) as PlayerBall;
    return CustomPaint(
      painter: PreviewPainter(
        [
          Offset(
            playerBall.position.x.roundToDouble() * 100,
            playerBall.position.y.roundToDouble() * 100,
          ),
          Offset(
            state.previewOffset!.dx -
                state.previewStart!.dx +
                playerBall.position.x * 100,
            state.previewOffset!.dy -
                state.previewStart!.dy +
                playerBall.position.y * 100,
          ),
        ],
      ),
    );
  }
}
