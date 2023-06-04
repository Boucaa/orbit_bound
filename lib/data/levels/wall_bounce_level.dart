import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/target.dart';
import 'package:space_balls/model/wall.dart';

class WallBounceLevel extends GameLevel {
  WallBounceLevel()
      : super(
          id: 'wall_bounce',
          name: 'Wall Bounce',
          description: 'Bounce the ball off the wall',
          gameObjects: [
            PlayerBall(
              mass: 1,
              initialVelocity: Vector2(-1, 0),
              initialPosition: Vector2(1.5, 4.8),
            ),
            Target(
              initialPosition: Vector2(2.5, 1),
            ),
            WallLine(
              Vector2(2.0, 1.3),
              Vector2(0.8, 2.5),
              isContactGameOver: false,
            ),
            WallLine(
              Vector2(3.0, 1.5),
              Vector2(1.8, 2.7),
              isContactGameOver: false,
            ),
          ],
          nonPhysicalComponents: [
            TextComponent(
              text: 'These walls are ok to hit. Use them to your advantage.',
              // 'test',
              anchor: Anchor.center,
              position: Vector2(1.5, 3.5),
              scale: Vector2.all(1 / 220.0),
              textRenderer: TextPaint(
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 22,
                ),
              ),
            )
          ],
        );
}
