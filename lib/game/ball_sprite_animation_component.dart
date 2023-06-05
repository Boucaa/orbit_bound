import 'dart:ui';

import 'package:flame/components.dart';
import 'package:space_balls/model/ball_object.dart';

class BallSpriteAnimationComponent extends SpriteAnimationComponent {
  final BallObject ballObject;

  BallSpriteAnimationComponent({
    required Image img,
    required this.ballObject,
  }) : super.fromFrameData(
          img,
          SpriteAnimationData.sequenced(
            textureSize: Vector2.all(128.0),
            amount: 32,
            stepTime: 0.05,
          ),
          size: Vector2.all(ballObject.radius * 2),
        );

  @override
  void update(double dt) {
    super.update(dt);
    position = ballObject.position - size / 2;
  }
}
