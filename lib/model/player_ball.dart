import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:space_balls/model/ball_object.dart';
import 'package:space_balls/model/game_object.dart';

class PlayerBall extends BallObject {
  PlayerBall({
    // required Vector2 position,
    // required Vector2 velocity,
    required double mass,
    super.initialVelocity,
    required super.initialPosition,
    super.fakePosition,
  }) : super(
          mass: mass,
          isStatic: true,
          spriteSheetPath: 'player.png',
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
    return PlayerBall(
      initialPosition: position,
      initialVelocity: velocity,
      mass: mass,
      fakePosition: position,
    );
  }

  void shoot(Vector2 force) {
    isStatic = false;
    body.linearVelocity = force;
    // body.applyLinearImpulse(
    //   force,
    //   point: position -
    //       Vector2(1, 1), // TODO bug in library? default value is world center
    // );
  }
}
