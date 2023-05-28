import 'package:equatable/equatable.dart';
import 'package:space_balls/model/game_object.dart';

class GameLevel extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<GameObject> gameObjects;

  const GameLevel({
    required this.id,
    required this.name,
    required this.description,
    required this.gameObjects,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        gameObjects,
      ];
}
