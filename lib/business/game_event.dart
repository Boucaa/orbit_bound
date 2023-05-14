part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class StartPreview extends GameEvent {
  final Offset offset;

  const StartPreview(this.offset);

  @override
  List<Object> get props => [offset];
}

class PreviewShot extends GameEvent {
  final Offset offset;

  const PreviewShot(this.offset);

  @override
  List<Object> get props => [offset];
}

class Shoot extends GameEvent {}
