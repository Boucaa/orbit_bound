import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/schwarzschild_hole.dart';
import 'package:space_balls/model/target.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SchwardschildLevel extends GameLevel {
  SchwardschildLevel(BuildContext context)
      : super(
    id: 'schwarzschild',
    name: AppLocalizations.of(context)!.schwarzschild_name,
    description: AppLocalizations.of(context)!.schwarzschild_description,
  gameObjects: [
            PlayerBall(
              mass: 1,
              initialVelocity: Vector2(-1, 0),
              initialPosition: Vector2(1.5, 4.8),
            ),
            Target(
              initialPosition: Vector2(1.5, 0.8),
            ),
            SchwardschildHole(
              initialPosition: Vector2(1.5, 3),
              mass: 1.5,
            ),
          ],
        );
}
