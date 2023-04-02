part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class Tick extends GameEvent {}

class Start extends GameEvent {}

class Stop extends GameEvent {}
