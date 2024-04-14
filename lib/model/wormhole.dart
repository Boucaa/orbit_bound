import 'package:space_balls/model/ball_object.dart';
import 'package:space_balls/model/game_object.dart';
import 'package:vector_math/vector_math_64.dart';

class Wormhole extends BallObject {
  Wormhole? target;

  Wormhole({
    required super.initialPosition,
    super.initialVelocity,
    super.mass = 0,
    super.isStatic = true,
    super.spritePath = 'wormhole.webp',
    super.spriteSheetPath,
    super.isContactGameOver = false,
    super.isSensor = true,
    super.radius = 0.35,
  });

  @override
  Vector2 calculateInteraction(GameObject other) {
    return Vector2.zero();
  }

  void setTarget(Wormhole target) {
    this.target = target;
    if (target.target != this) {
      target.setTarget(this);
    }
  }
}
