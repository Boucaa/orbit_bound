import 'package:space_balls/model/game_object.dart';
import 'package:vector_math/vector_math_64.dart';

class target extends GameObject {
  target({
    required Vector2 position,
    required Vector2 velocity,
    required double mass,
  }) : super(
    position: position,
    velocity: velocity,
    mass: mass,
    isStatic: false,
  );

  @override
  Vector2 calculateInteraction(GameObject other) {
/*
    return Vector2(
          other.position.x - position.x,
          other.position.y - position.y,
        ).normalized() *
        2;
*/
    return Vector2.zero();
  }

  @override
  GameObject copyWith({
    Vector2? position,
    Vector2? velocity,
    double? mass,
  }) {
    return target(
      position: position ?? this.position,
      velocity: velocity ?? this.velocity,
      mass: mass ?? this.mass,
    );
  }
}
