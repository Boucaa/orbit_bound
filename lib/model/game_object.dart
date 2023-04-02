import 'package:vector_math/vector_math_64.dart';

abstract class GameObject {
  final Vector2 position;
  final Vector2 velocity;
  final double mass;

  GameObject({
    required this.position,
    required this.velocity,
    required this.mass,
  });

  Vector2 calculateInteraction(Duration dt, GameObject other);
}
