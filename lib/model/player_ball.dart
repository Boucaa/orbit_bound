import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:space_balls/model/ball_object.dart';
import 'package:space_balls/model/game_object.dart';

class PlayerBall extends BallObject {
  PlayerBall({
    required double mass,
    super.initialVelocity,
    required super.initialPosition,
  }) : super(
          mass: mass,
          isStatic: true,
          spriteSheetPath: 'player.png',
          isContactGameOver: false,
        );

  @override
  Vector2 calculateInteraction(GameObject other) {
    return Vector2.zero();
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
