import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:space_balls/model/game_object.dart';

abstract class BallObject extends GameObject {
  final Vector2? initialVelocity;
  final Vector2 initialPosition;
  final double radius;
  final String? spritePath;
  final String? spriteSheetPath;
  final bool customPaint;
  final double renderRadius;
  final bool isSensor;

  BallObject({
    // required super.velocity,
    required super.mass,
    required super.isStatic,
    this.initialVelocity,
    required this.initialPosition,
    this.radius = 0.1,
    this.spritePath,
    this.spriteSheetPath,
    super.isContactGameOver = true,
    this.customPaint = false,
    double? renderRadius,
    this.isSensor = false,
  }) : renderRadius = renderRadius ?? radius;

  @override
  set isStatic(bool value) {
    super.isStatic = value;
    body.setType(value ? BodyType.static : BodyType.dynamic);
  }

  @override
  Body createBody() {
    final shape = CircleShape();
    shape.radius = radius;

    final fixtureDef = FixtureDef(
      shape,
      restitution: 0.8,
      density: 1.0,
      friction: 0.4,
      isSensor: isSensor,
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
