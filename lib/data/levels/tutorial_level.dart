import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/target.dart';

import '../../game/components/tutorial_animation_component.dart';

class TutorialLevel extends GameLevel {
  TutorialLevel(BuildContext context)
      : super(
          id: 'tutorial',
          name: AppLocalizations.of(context)!.tutorial_name,
          description: AppLocalizations.of(context)!.tutorial_description,
          gameObjects: [
            PlayerBall(
              mass: 1,
              initialVelocity: Vector2(-1, 0),
              initialPosition: Vector2(1.5, 3.5),
            ),
            Target(
              initialPosition: Vector2(1.5, 0.8),
            ),
          ],
          nonPhysicalComponents: [
            TextComponent(
              text: AppLocalizations.of(context)!.target_description,
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
              text: AppLocalizations.of(context)!.ball_description,
              // 'test',
              anchor: Anchor.center,
              position: Vector2(1.5, 2.75),
              scale: Vector2.all(1 / 220.0),
              textRenderer: TextPaint(
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 22,
                ),
              ),
            ),
            // TextComponent(
            //   text: AppLocalizations.of(context)!.wall_warning,
            //   // 'test',
            //   anchor: Anchor.center,
            //   position: Vector2(1.5, 1.7),
            //   scale: Vector2.all(1 / 220.0),
            //   textRenderer: TextPaint(
            //     style: const TextStyle(
            //       color: Color(0xFFFFFFFF),
            //       fontSize: 22,
            //     ),
            //   ),
            // ),
            TextComponent(
              text: AppLocalizations.of(context)!.shooting_instruction,
              // 'test',
              anchor: Anchor.center,
              position: Vector2(1.5, 3),
              scale: Vector2.all(1 / 220.0),
              textRenderer: TextPaint(
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 22,
                ),
              ),
            ),
            TutorialAnimationComponent(),
          ],
        );
}
