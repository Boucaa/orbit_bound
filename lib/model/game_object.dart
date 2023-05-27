import 'package:flame_forge2d/body_component.dart';
import 'package:vector_math/vector_math_64.dart';

abstract class GameObject extends BodyComponent {
  final double mass;
  bool isStatic;
  final bool isContactGameOver;

  Vector2 get velocity => body.linearVelocity;

  Vector2 get position => body.position;

  GameObject({
    // required this.velocity,
    required this.mass,
    required this.isStatic,
    this.isContactGameOver = true,
  }) : super(
          renderBody: false,
        );

  Vector2 calculateInteraction(GameObject other);
}
