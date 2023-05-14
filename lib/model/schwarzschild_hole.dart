import 'dart:math';

import 'package:space_balls/model/ball_object.dart';
import 'package:space_balls/model/game_object.dart';
import 'package:vector_math/vector_math_64.dart';

class SchwardschildHole extends BallObject {
  SchwardschildHole({
    required super.initialPosition,
    super.initialVelocity,
    required double mass,
    super.fakePosition,
    super.isStatic = true,
  }) : super(
    // velocity: velocity,
    mass: mass,

  );

  @override
  Vector2 calculateInteraction(GameObject other) {
    double distance = pow(
        pow(other.position.x - position.x, 2) +
            pow(other.position.y - position.y, 2),
        1 / 2)
        .toDouble();
    return -Vector2(
        other.position.x - position.x, other.position.y - position.y) * (
        mass/pow(distance, 3) + pow(mass, 2)/pow(distance, 5)*0.1
        );

  }

  @override
  GameObject withFakePosition(Vector2 position) {
    return SchwardschildHole(
      initialPosition: position,
      initialVelocity: velocity,
      mass: mass,
      fakePosition: position,
    );
  }
}
