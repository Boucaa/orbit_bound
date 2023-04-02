part of 'game_bloc.dart';

class GameState extends Equatable {
  final List<GameObject> objects;
  final bool isRunning;

  const GameState({
    this.objects = const [],
    this.isRunning = false,
  });

  GameState copyWith({
    List<GameObject>? objects,
    bool? isRunning,
  }) {
    return GameState(
      objects: objects ?? this.objects,
      isRunning: isRunning ?? this.isRunning,
    );
  }

  @override
  List<Object> get props => [
        objects,
        isRunning,
      ];
}
