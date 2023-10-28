import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/newton_object.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/target.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewtonianLevel extends GameLevel {
  NewtonianLevel(BuildContext context)
      : super(
    id: 'newtonian_object',
    name: AppLocalizations.of(context)!.newtonian_object_name,
    description: AppLocalizations.of(context)!.newtonian_object_description,
  gameObjects: [
            PlayerBall(
              mass: 1,
              initialVelocity: Vector2(-1, 0),
              initialPosition: Vector2(1.5, 4.8),
            ),
            Target(
              initialPosition: Vector2(1.5, 0.8),
            ),
            NewtonObject(
              initialPosition: Vector2(1.5, 3),
              mass: 2,
            ),
          ],
        );
}
