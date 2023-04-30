import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:space_balls/model/game_object.dart';
import 'package:space_balls/model/newton_object.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:vector_math/vector_math_64.dart';

part 'game_event.dart';

part 'game_state.dart';

final _log = Logger('GameBloc');

class GameBloc extends Bloc<GameEvent, GameState> {
  Timer? tickTimer;

  GameBloc()
      : super(
          GameState(
            objects: [
              // PlayerBall(
              //   position: Vector2(0, 0),
              //   velocity: Vector2(0, 0),
              //   mass: 1,
              // ),
              PlayerBall(
                position: Vector2(200, 400),
                velocity: Vector2(1, 0),
                mass: 1,
              ),
              NewtonObject(
                position: Vector2(200, 500),
                velocity: Vector2.zero(),
                mass: 100,
              ),
            ],
            lastTick: DateTime.now(),
          ),
        ) {
    on<Start>((event, emit) {
      tickTimer?.cancel();
      tickTimer = Timer.periodic(
        const Duration(milliseconds: 16),
        (timer) => add(Tick()),
      );
      emit(state.copyWith(isRunning: true));
    });
    on<Stop>((event, emit) {
      tickTimer?.cancel();
      emit(state.copyWith(isRunning: false));
    });
    on<Tick>(
          (event, emit) {
        final time = DateTime.now();
        final timeDiff = time.difference(state.lastTick).inMicroseconds;
        const double timeStep = 16*0.5;
        // _log.fine('Tick: $timeDiff');
        if (timeDiff > 30000) {
          _log.fine('long tick: $timeDiff');
        }
        final objects = state.objects;
        final dx = objects[0].position.x - objects[1].position.x;
        final dy = objects[0].position.y - objects[1].position.y;
        final e = 0.5 *
            (pow(objects[0].velocity.x, 2) +
                pow(objects[0].velocity.y, 2)) -
            10000 / pow(pow(dx, 2) + pow(dy, 2), 0.5);
        _log.fine('Energy: $e');
        final newObjects = <GameObject>[];
        for (var i = 0; i < objects.length; i++) {
          if (objects[i].isStatic) {
            newObjects.add(objects[i]);
            continue;
          }
          var acceleration = Vector2.zero();
          Vector2 calcAcceleration(Vector2 testPosition){
            for (var j = 0; j < objects.length; j++) {
              if (i == j) {
                continue;
              }

              final objectA = objects[i].copyWith(
                position: testPosition,
              );
              final objectB = objects[j];

              final interaction = objectB.calculateInteraction(objectA);
              acceleration += interaction;
            }
            return acceleration;
          }

          // Calculate the k1 values
          final k1Velocity = calcAcceleration(objects[i].position) * timeStep;
          final k1Position = objects[i].velocity * timeStep;

          // Calculate the k2 values
          final k2Velocity = calcAcceleration(objects[i].position + k1Position * 0.5) * timeStep;
          final k2Position = (objects[i].velocity + k1Velocity * 0.5) * timeStep;

          // Calculate the k3 values
          final k3Velocity = calcAcceleration(objects[i].position + k2Position * 0.5) * timeStep;
          final k3Position = (objects[i].velocity + k2Velocity * 0.5) * timeStep;

          // Calculate the k4 values
          final k4Velocity = calcAcceleration(objects[i].position + k3Position) * timeStep;
          final k4Position = (objects[i].velocity + k3Velocity) * timeStep;

          // Update the velocity and position
          final newVelocity = objects[i].velocity + (k1Velocity + k2Velocity * 2 + k3Velocity * 2 + k4Velocity) * (1 / 6);
          final newPosition = objects[i].position + (k1Position + k2Position * 2 + k3Position * 2 + k4Position) * (1 / 6);


          // final newVelocity =
          //     objects[i].velocity + acceleration * (16000 * 0.000001);
          final newObject = objects[i].copyWith(
            velocity: newVelocity,
            position: newPosition,//objects[i].position + newVelocity * (16000*0.000001),
          );
          newObjects.add(newObject);
        }

        emit(state.copyWith(
          objects: newObjects,
          lastTick: time,
        ));
      },
      transformer: droppable(),
    );
    on<StartPreview>((event, emit) {
      emit(state.copyWith(previewStart: () => event.offset));
    });
    on<PreviewShot>((event, emit) {
      emit(state.copyWith(previewOffset: () => event.offset));
    });
    on<Shoot>((event, emit) {
      if (state.previewOffset == null) {
        return;
      }
      final objects = state.objects;
      final newObjects = <GameObject>[];
      for (var i = 0; i < objects.length; i++) {
        if (objects[i] is PlayerBall) {
          final newObject = objects[i].copyWith(
            velocity: Vector2(
              (state.previewStart!.dx - state.previewOffset!.dx) / 100,
              (state.previewStart!.dy - state.previewOffset!.dy) / 100,
            ),
          );
          newObjects.add(newObject);
        } else {
          newObjects.add(objects[i]);
        }
      }
      emit(state.copyWith(
        objects: newObjects,
        previewOffset: () => null,
      ));
    });
  }

  @override
  Future<void> close() {
    tickTimer?.cancel();
    return super.close();
  }
}
