part of 'shot_bloc.dart';

@immutable
sealed class ShotEvent {}

class AddShot extends ShotEvent {
  final Shot shot;
  final String levelId;

  AddShot({
    required this.shot,
    required this.levelId,
  });
}
