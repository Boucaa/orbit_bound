import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:space_balls/business/game_bloc.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/ui/preview_painter.dart';

final _log = Logger('Game');

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

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
          },
          child: Container(
            color: Colors.black,
            child: Stack(
              children: [
                ...state.objects.map((object) {
                  return Positioned(
                    left: object.position.x,
                    top: object.position.y,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }).toList(),
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
    final playerBall = state.objects.firstWhere(
      (element) => element is PlayerBall,
    ) as PlayerBall;
    return CustomPaint(
      painter: PreviewPainter(
        [
          Offset(
            playerBall.position.x.roundToDouble(),
            playerBall.position.y.roundToDouble(),
          ),
          Offset(
            state.previewOffset!.dx -
                state.previewStart!.dx +
                playerBall.position.x,
            state.previewOffset!.dy -
                state.previewStart!.dy +
                playerBall.position.y,
          ),
        ],
      ),
    );
  }
}
