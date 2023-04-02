part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class Tick extends GameEvent {}

class Start extends GameEvent {}

class Stop extends GameEvent {}

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
