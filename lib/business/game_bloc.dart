import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:space_balls/model/game_object.dart';

part 'game_event.dart';

part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState()) {
    on<GameEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
