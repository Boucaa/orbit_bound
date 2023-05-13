import 'package:space_balls/model/ball_object.dart';
import 'package:space_balls/model/game_object.dart';
import 'package:vector_math/vector_math_64.dart';

class Target extends BallObject {
  Target({
    required super.initialPosition,
    super.fakePosition,
  }) : super(
          mass: 1,
          isStatic: true,
          radius: 0.5,
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
  GameObject withFakePosition(Vector2 position) {
    return Target(
      initialPosition: position,
      fakePosition: position,
    );
  }
}
