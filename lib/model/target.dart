import 'package:space_balls/model/ball_object.dart';
import 'package:space_balls/model/game_object.dart';
import 'package:vector_math/vector_math_64.dart';

class Target extends BallObject {
  Target({
    required super.initialPosition,
  }) : super(
          mass: 1,
          isStatic: true,
          radius: 0.25,
          spritePath: 'portalv2.png',
        );

  @override
  Vector2 calculateInteraction(GameObject other) {
    return Vector2.zero();
  }
}
