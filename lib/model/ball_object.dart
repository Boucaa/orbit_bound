import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:space_balls/model/game_object.dart';

abstract class BallObject extends GameObject {
  final Vector2? initialVelocity;
  final Vector2 initialPosition;

  BallObject({
    // required super.velocity,
    required super.mass,
    required super.isStatic,
    this.initialVelocity,
    required this.initialPosition,
    super.fakePosition,
  });

  @override
  Body createBody() {
    final shape = CircleShape();
    shape.radius = 5;

    final fixtureDef = FixtureDef(
      shape,
      restitution: 0.8,
      density: 1.0,
      friction: 0.4,
    );

    final bodyDef = BodyDef(
      userData: this,
      angularDamping: 0.8,
      position: initialPosition,
      type: isStatic ? BodyType.static : BodyType.dynamic,
      linearVelocity: initialVelocity,
    );

    return world.createBody(bodyDef)
      ..createFixture(fixtureDef)
      ..userData = this;
  }
}
