import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:space_balls/model/shot.dart';

part 'shot_event.dart';
part 'shot_state.dart';

class ShotBloc extends Bloc<ShotEvent, ShotState> {
  ShotBloc() : super(ShotState()) {
    on<AddShot>((event, emit) {
      final shots = state.shots[event.levelId] ?? [];
      final updatedShots = [...shots, event.shot];
      if (updatedShots.length > 3) {
        updatedShots.removeAt(0);
      }
      emit(
        state.copyWith(
          shots: {
            ...state.shots,
            event.levelId: updatedShots,
          },
        ),
      );
    });
  }
}
