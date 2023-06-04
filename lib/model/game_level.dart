import 'package:equatable/equatable.dart';
import 'package:flame/components.dart';
import 'package:space_balls/model/game_object.dart';

class GameLevel extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<GameObject> gameObjects;
  final List<Component> nonPhysicalComponents;

  const GameLevel({
    required this.id,
    required this.name,
    required this.description,
    required this.gameObjects,
    this.nonPhysicalComponents = const [],
  });

  @override
  List<Object?> get props => [
        name,
        description,
        gameObjects,
      ];
}
