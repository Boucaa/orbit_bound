import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:space_balls/game/space_balls_game.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/ui/preview_painter.dart';

import '../business/game_bloc.dart';

final _log = Logger('FlameWidget');

class FlameWidget extends StatefulWidget {
  final GameLevel level;

  const FlameWidget({
    Key? key,
    required this.level,
  }) : super(key: key);

  @override
  State<FlameWidget> createState() => _FlameWidgetState();
}

class _FlameWidgetState extends State<FlameWidget> {
  late final game = SpaceBallsGame(
    level: widget.level,
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
            color: Colors.grey,
            child: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: SizedBox(
                      width: 3,
                      height: 3.0 * 16.0 / 9.0,
                      child: GameWidget(game: game),
                    ),
                  ),
                ),
                if (state.previewOffset != null)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: _previewPainter(context, state),
                  ),
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
