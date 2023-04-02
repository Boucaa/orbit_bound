import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:space_balls/model/game_object.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:vector_math/vector_math_64.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  Timer? tickTimer;

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
                position: Vector2(300, 300),
                velocity: Vector2(0, 0),
                mass: 1,
              )
            ],
          ),
        ) {
    on<Start>((event, emit) {
      tickTimer?.cancel();
      tickTimer = Timer.periodic(
        const Duration(milliseconds: 16),
        (timer) => add(Tick()),
      );
    });
    on<Tick>((event, emit) {
      final objects = state.objects;
      final newObjects = <GameObject>[];
      for (var i = 0; i < objects.length; i++) {
        var acceleration = Vector2.zero();
        for (var j = 0; j < objects.length; j++) {
          if (i == j) {
            continue;
          }
          final objectA = objects[i];
          final objectB = objects[j];
          final interaction = objectA.calculateInteraction(objectB);
          acceleration += interaction;
        }
        final newVelocity = objects[i].velocity + acceleration;
        final newObject = objects[i].copyWith(
          velocity: newVelocity,
          position: objects[i].position + newVelocity,
        );
        newObjects.add(newObject);
      }
      emit(state.copyWith(objects: newObjects));
    });
  }

  @override
  Future<void> close() {
    tickTimer?.cancel();
    return super.close();
  }
}
