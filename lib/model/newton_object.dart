import 'dart:math';

import 'package:space_balls/model/game_object.dart';
import 'package:vector_math/vector_math_64.dart';

class NewtonObject extends GameObject {
  NewtonObject({
    required Vector2 position,
    required Vector2 velocity,
    required double mass,
  }) : super(
          position: position,
          velocity: velocity,
          mass: mass,
          isStatic: true,
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

  @override
  GameObject copyWith({
    Vector2? position,
    Vector2? velocity,
    double? mass,
  }) {
    return NewtonObject(
      position: position ?? this.position,
      velocity: velocity ?? this.velocity,
      mass: mass ?? this.mass,
    );
  }
}
