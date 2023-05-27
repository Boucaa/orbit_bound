import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:space_balls/business/user_bloc.dart';
import 'package:space_balls/game/space_balls_game.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/ui/game_page.dart';

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
  final GlobalKey _gameKey = GlobalKey();

  late final game = SpaceBallsGame(
    gameKey: _gameKey,
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
    return Container(
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
                  child: GameWidget(
                    game: game,
                    key: _gameKey,
                  ),
                ),
              ),
            ),
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
                    backgroundColor: !game.paused ? Colors.red : Colors.green,
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
    );
  }
}
