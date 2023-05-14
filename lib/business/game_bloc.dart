import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/game_object.dart';
import 'package:space_balls/model/player_ball.dart';

part 'game_event.dart';

part 'game_state.dart';

final _log = Logger('GameBloc');

// TODO remove or rewrite, keeping for now just for the controls
class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc(GameLevel level)
      : super(
          GameState(
            level: level,
            lastTick: DateTime.now(),
          ),
        ) {
    on<StartPreview>((event, emit) {
      if (!state.level.gameObjects
          .firstWhere((element) => element is PlayerBall)
          .isStatic) {
        return;
      }
      emit(state.copyWith(previewStart: () => event.offset));
    });
    on<PreviewShot>((event, emit) {
      emit(state.copyWith(previewOffset: () => event.offset));
    });
    on<Shoot>((event, emit) {
      emit(state.copyWith(
        previewOffset: () => null,
      ));
    });
  }
}
