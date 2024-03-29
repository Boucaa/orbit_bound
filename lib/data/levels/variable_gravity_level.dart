import 'package:flutter/widgets.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/target.dart';
import 'package:space_balls/model/variable_gravity_object.dart';
import 'package:space_balls/model/wall.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VariableGravityLevel extends GameLevel {
  VariableGravityLevel(BuildContext context)
      : super(
    id: 'variable_gravity',
    name: AppLocalizations.of(context)!.variable_gravity_name,
    description: AppLocalizations.of(context)!.variable_gravity_description,
 gameObjects: [
            PlayerBall(
              mass: 1,
              initialVelocity: Vector2(-1, 0),
              initialPosition: Vector2(1.5, 4.8),
            ),
            Target(
              initialPosition: Vector2(1.5, 0.8),
            ),
            VariableGravityObject(
              initialPosition: Vector2(1.5, 3),
              mass: 1.5,
              exponent: 3,
            ),
            WallLine(
              Vector2(0, 3),
              Vector2(1.4, 3),
              isContactGameOver: true,
            ),
            WallLine(
              Vector2(1.6, 3),
              Vector2(2, 3),
              isContactGameOver: true,
            ),
            WallLine(
              Vector2(2.4, 3),
              Vector2(3, 3),
              isContactGameOver: true,
            ),
          ],
        );
}
