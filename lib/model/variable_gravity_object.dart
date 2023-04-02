import 'dart:math';

import 'package:space_balls/model/game_object.dart';
import 'package:vector_math/vector_math_64.dart';

class VariableGravityObject extends GameObject {
  final double exponent;

  VariableGravityObject({
    required Vector2 position,
    required Vector2 velocity,
    required double mass,
    required this.exponent
  }) : super(
    position: position,
    velocity: velocity,
    mass: mass,
    isStatic: true,
  );

  @override
  Vector2 calculateInteraction(GameObject other) {
    double distance = sqrt(pow(other.position.x-position.x,2)+pow(other.position.y-position.y,2));
    return Vector2(other.position.x-position.x,other.position.y-position.y)/pow(distance, exponent).toDouble()*mass;
  }
  @override
  GameObject copyWith({
    Vector2? position,
    Vector2? velocity,
    double? mass,
  }) {
    return VariableGravityObject(
      position: position ?? this.position,
      velocity: velocity ?? this.velocity,
      mass: mass ?? this.mass,
      exponent: exponent ?? this.exponent,
    );
  }
}