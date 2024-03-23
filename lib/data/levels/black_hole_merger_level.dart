import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/schwarzschild_hole.dart';
import 'package:space_balls/model/target.dart';

class BlackHoleMergerLevel extends GameLevel {
  BlackHoleMergerLevel(BuildContext context)
      : super(
          id: 'black_hole_merger',
          name: AppLocalizations.of(context)!.black_hole_merger_name,
          description:
              AppLocalizations.of(context)!.black_hole_merger_description,
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
              initialPosition: Vector2(2.2, 3),
              mass: 1.5,
              initialVelocity: Vector2(0, 0.62),
              isStatic: false,
              radius: 0.12,
            ),
            SchwardschildHole(
              initialPosition: Vector2(0.8, 3),
              mass: 1.5,
              isStatic: false,
              initialVelocity: Vector2(0, -0.62),
              radius: 0.12,
            ),
          ],
        );
}
