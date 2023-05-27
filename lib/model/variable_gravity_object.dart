import 'dart:math';

import 'package:space_balls/model/ball_object.dart';
import 'package:space_balls/model/game_object.dart';
import 'package:vector_math/vector_math_64.dart';

class VariableGravityObject extends BallObject {
  final double exponent;

  VariableGravityObject({
    required super.initialPosition,
    required double mass,
    required this.exponent,
  }) : super(
          mass: mass,
          isStatic: true,
        );

  @override
  Vector2 calculateInteraction(GameObject other) {
    double distance = sqrt(pow(other.position.x - position.x, 2) +
        pow(other.position.y - position.y, 2));
    return -Vector2(
            other.position.x - position.x, other.position.y - position.y) /
        pow(distance, exponent).toDouble() *
        mass;
  }
}
