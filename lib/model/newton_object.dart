import 'dart:math';

import 'package:space_balls/model/ball_object.dart';
import 'package:space_balls/model/game_object.dart';
import 'package:vector_math/vector_math_64.dart';

class NewtonObject extends BallObject {
  NewtonObject({
    required super.initialPosition,
    super.initialVelocity,
    required double mass,
    super.isStatic = true,
    super.spritePath,
    super.spriteSheetPath,
  }) : super(
          mass: mass,
        );

  @override
  Vector2 calculateInteraction(GameObject other) {
    double distanceSquared = pow(
            pow(other.position.x - position.x, 2) +
                pow(other.position.y - position.y, 2),
            3 / 2)
        .toDouble();
    return -Vector2(
            other.position.x - position.x, other.position.y - position.y) /
        distanceSquared *
        mass;
  }
}
