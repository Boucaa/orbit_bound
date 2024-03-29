import 'package:flutter/widgets.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/newton_object.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/target.dart';
import 'package:space_balls/model/wall.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FzuLevel extends GameLevel {
  FzuLevel(BuildContext context)
      : super(
    id: 'fzu_level',
    name: AppLocalizations.of(context)!.fzu_level_name,
    description: AppLocalizations.of(context)!.fzu_level_description,
    gameObjects: [
            PlayerBall(
              mass: 1,
              initialVelocity: Vector2(-1, 0),
              initialPosition: Vector2(2, 1.5),
            ),
            Target(
              initialPosition: Vector2(1.5, 4.5),
            ),
            NewtonObject(
              initialPosition: Vector2(0.5, 3),
              mass: 1,
            ),
            NewtonObject(
              initialPosition: Vector2(2, 3.5),
              mass: 1,
              isStatic: true,
            ),
            WallLine(
              Vector2(1.5, 0.5),
              Vector2(0.5, 0.5),
              isContactGameOver: false,
            ),
            WallLine(
              Vector2(1, 1.5),
              Vector2(1.5, 1.5),
              isContactGameOver: false,
            ),
            WallLine(
              Vector2(0.5, 0.5),
              Vector2(0.5, 2.5),
              isContactGameOver: false,
            ),
            WallLine(
              Vector2(1.5, 2),
              Vector2(2.5, 2),
              isContactGameOver: true,
            ),
            WallLine(
              Vector2(1.5, 3),
              Vector2(2.5, 3),
              isContactGameOver: true,
            ),
            WallLine(
              Vector2(1.5, 3),
              Vector2(2.5, 2),
              isContactGameOver: true,
            ),
            WallLine(
              Vector2(1, 4),
              Vector2(1, 5),
              isContactGameOver: true,
            ),
            WallLine(
              Vector2(2, 4),
              Vector2(2, 5),
              isContactGameOver: true,
            ),
            WallLine(
              Vector2(1, 5),
              Vector2(2, 5),
              isContactGameOver: true,
            ),
          ],
        );
}
