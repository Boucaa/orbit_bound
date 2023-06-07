import 'dart:math';

import 'package:space_balls/model/ball_object.dart';
import 'package:space_balls/model/game_object.dart';
import 'package:vector_math/vector_math_64.dart';

class KerrHole extends BallObject {
  final double spin;
  final double drag;

  KerrHole({
    required super.initialPosition,
    super.initialVelocity,
    required double mass,
    required this.spin,
    required this.drag,
    super.isStatic = true,
  }) : super(
          // velocity: velocity,
          spriteSheetPath:  'black_hole_ring.png',
          mass: mass,
        );

  @override
  Vector2 calculateInteraction(GameObject other) {
    double distance = pow(
            pow(other.position.x - position.x, 2) +
                pow(other.position.y - position.y, 2),
            1 / 2)
        .toDouble();
    Vector2 dragfield = -Vector2(
            -other.position.y + position.y, other.position.x - position.x) *
        (spin / pow(distance, 3));
    return -Vector2(
                other.position.x - position.x, other.position.y - position.y) *
            (mass / pow(distance, 3) + pow(mass, 2) / pow(distance, 5) * 0.1) +
        (dragfield -
                Vector2(other.velocity.x - velocity.x,
                    other.velocity.x - velocity.x)) *
            drag;
  }
}
