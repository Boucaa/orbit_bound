part of 'game_bloc.dart';

class GameState extends Equatable {
  final List<GameObject> objects;

  const GameState({
    this.objects = const [],
  });

  @override
  List<Object> get props => [];
}
