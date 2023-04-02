import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:space_balls/model/game_object.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:vector_math/vector_math_64.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc()
      : super(
          GameState(
            objects: [
              PlayerBall(
                position: Vector2(0, 0),
                velocity: Vector2(0, 0),
                mass: 1,
              ),
              PlayerBall(
                position: Vector2(100, 100),
                velocity: Vector2(0, 0),
                mass: 1,
              )
            ],
          ),
        ) {
    on<GameEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
