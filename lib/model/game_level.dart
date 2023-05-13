import 'package:equatable/equatable.dart';
import 'package:space_balls/model/game_object.dart';

class GameLevel extends Equatable {
  const GameLevel({
    required this.name,
    required this.description,
    required this.gameObjects,
  });

  final String name;
  final String description;
  final List<GameObject> gameObjects;

  @override
  List<Object?> get props => [
        name,
        description,
        gameObjects,
      ];
}
