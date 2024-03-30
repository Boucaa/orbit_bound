import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/target.dart';
import 'package:space_balls/model/wall.dart';

class WallBounceLevel extends GameLevel {
  WallBounceLevel(BuildContext context)
      : super(
          id: 'wall_bounce',
          name: AppLocalizations.of(context)!.wall_bounce_name,
          description: AppLocalizations.of(context)!.wall_bounce_description,
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
              Vector2(0.6, 2.7),
              isContactGameOver: false,
            ),
            WallLine(
              Vector2(2.9, 1.6),
              Vector2(1.8, 2.7),
              isContactGameOver: false,
            ),
          ],
          nonPhysicalComponents: [
            TextComponent(
              text: AppLocalizations.of(context)!.good_walls_description_0,
              anchor: Anchor.center,
              position: Vector2(1.5, 3.5),
              scale: Vector2.all(1 / 220.0),
              textRenderer: TextPaint(
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 22,
                ),
              ),
            ),
            TextComponent(
              text: AppLocalizations.of(context)!.good_walls_description_1,
              anchor: Anchor.center,
              position: Vector2(1.5, 3.7),
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
