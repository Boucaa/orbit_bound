part of 'shot_bloc.dart';

class ShotState {
  // level id -> shots
  final Map<String, List<Shot>> shots;

  ShotState({
    this.shots = const {},
  });

  ShotState copyWith({
    Map<String, List<Shot>>? shots,
  }) {
    return ShotState(
      shots: shots ?? this.shots,
    );
  }
}
