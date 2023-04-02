part of 'game_bloc.dart';

class GameState extends Equatable {
  final List<GameObject> objects;

  const GameState({
    this.objects = const [],
  });

  GameState copyWith({
    List<GameObject>? objects,
  }) {
    return GameState(
      objects: objects ?? this.objects,
    );
  }

  @override
  List<Object> get props => [
        objects,
  ];
}
