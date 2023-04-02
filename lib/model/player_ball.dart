import 'package:space_balls/model/game_object.dart';
import 'package:vector_math/vector_math_64.dart';

class PlayerBall extends GameObject {
  PlayerBall({
    required Vector2 position,
    required Vector2 velocity,
    required double mass,
  }) : super(
          position: position,
          velocity: velocity,
          mass: mass,
        );

  @override
  Vector2 calculateInteraction(GameObject other) {
    return Vector2.zero();
  }
}
