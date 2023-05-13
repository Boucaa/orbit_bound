import 'package:flame_forge2d/body_component.dart';
import 'package:vector_math/vector_math_64.dart';

abstract class GameObject extends BodyComponent {
  // final Vector2 velocity;
  final double mass;
  bool isStatic;
  final Vector2? fakePosition;

  Vector2 get velocity =>
      fakePosition != null ? Vector2.zero() : body.linearVelocity;

  Vector2 get position => fakePosition ?? body.position;

  GameObject({
    // required this.velocity,
    required this.mass,
    required this.isStatic,
    this.fakePosition,
  });

  Vector2 calculateInteraction(GameObject other);

  GameObject withFakePosition(Vector2 position);
}
