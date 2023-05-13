import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/game_object.dart';

part 'game_event.dart';

part 'game_state.dart';

final _log = Logger('GameBloc');

class GameBloc extends Bloc<GameEvent, GameState> {
  Timer? tickTimer;

  GameBloc(GameLevel level)
      : super(
          GameState(
            level: level,
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
    on<StartPreview>((event, emit) {
      emit(state.copyWith(previewStart: () => event.offset));
    });
    on<PreviewShot>((event, emit) {
      emit(state.copyWith(previewOffset: () => event.offset));
    });
    // on<Shoot>((event, emit) {
    //   if (state.previewOffset == null) {
    //     return;
    //   }
    //   final objects = state.objects;
    //   final newObjects = <GameObject>[];
    //   for (var i = 0; i < objects.length; i++) {
    //     if (objects[i] is PlayerBall) {
    //       final newObject = objects[i].copyWith(
    //         velocity: Vector2(
    //           (state.previewStart!.dx - state.previewOffset!.dx) / 100,
    //           (state.previewStart!.dy - state.previewOffset!.dy) / 100,
    //         ),
    //       );
    //       newObjects.add(newObject);
    //     } else {
    //       newObjects.add(objects[i]);
    //     }
    //   }
    //   emit(state.copyWith(
    //     objects: newObjects,
    //     previewOffset: () => null,
    //   ));
    // });
  }

  @override
  Future<void> close() {
    tickTimer?.cancel();
    return super.close();
  }
}
