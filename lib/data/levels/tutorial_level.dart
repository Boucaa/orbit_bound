import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/target.dart';

class TutorialLevel extends GameLevel {
  TutorialLevel()
      : super(
          id: 'tutorial',
          name: 'Tutorial',
          description:
              'Welcome to Space Balls! This is a tutorial level to get you started.',
          gameObjects: [
            PlayerBall(
              mass: 1,
              initialVelocity: Vector2(-1, 0),
              initialPosition: Vector2(1.5, 4.8),
            ),
            Target(
              initialPosition: Vector2(1.5, 0.8),
            ),
          ],
          nonPhysicalComponents: [
            TextComponent(
              text: 'This is the target. Your goal is to hit it with the ball.',
              position: Vector2(1.5, 1.3),
              anchor: Anchor.center,
              // this is necessary to get the correct position, it's broken somehow
              scale: Vector2.all(1 / 220.0),
              textRenderer: TextPaint(
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 22,
                ),
              ),
            ),
            TextComponent(
              text: 'This is the ball.',
              // 'test',
              anchor: Anchor.center,
              position: Vector2(1.5, 4.35),
              scale: Vector2.all(1 / 220.0),
              textRenderer: TextPaint(
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 22,
                ),
              ),
            ),
            TextComponent(
              text: 'Don\'t hit the walls and reach the target.',
              // 'test',
              anchor: Anchor.center,
              position: Vector2(1.5, 2.5),
              scale: Vector2.all(1 / 220.0),
              textRenderer: TextPaint(
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 22,
                ),
              ),
            ),
            TextComponent(
              text: 'You can shoot it by dragging your finger or mouse.',
              // 'test',
              anchor: Anchor.center,
              position: Vector2(1.5, 4.5),
              scale: Vector2.all(1 / 220.0),
              textRenderer: TextPaint(
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 22,
                ),
              ),
            ),
          ],
        );
}
