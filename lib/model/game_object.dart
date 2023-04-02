import 'package:vector_math/vector_math_64.dart';

abstract class GameObject {
  final Vector2 position;
  final Vector2 velocity;
  final double mass;
  final bool isStatic;

  GameObject({
    required this.position,
    required this.velocity,
    required this.mass,
    required this.isStatic,
  });

  Vector2 calculateInteraction(GameObject other);

  GameObject copyWith({
    Vector2? position,
    Vector2? velocity,
    double? mass,
  });
}