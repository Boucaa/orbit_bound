import 'package:flutter/widgets.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/newton_object.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/target.dart';
import 'package:space_balls/model/wall.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SlalomLevel extends GameLevel {
  SlalomLevel(BuildContext context)
      : super(
    id: 'slalom',
    name: AppLocalizations.of(context)!.slalom_name,
    description: AppLocalizations.of(context)!.slalom_description,
   gameObjects: [
            PlayerBall(
              mass: 1,
              initialVelocity: Vector2(-1, 0),
              initialPosition: Vector2(1.5, 4.8),
            ),
            Target(
              initialPosition: Vector2(1.5, 0.7),
            ),
            NewtonObject(
              initialPosition: Vector2(1.5, 1.8),
              mass: 1.5,
            ),
            NewtonObject(
              initialPosition: Vector2(1.5, 2.9),
              mass: 1.5,
            ),
            NewtonObject(
              initialPosition: Vector2(1.5, 4),
              mass: 1.5,
            ),
            WallLine(
              Vector2(0, 4),
              Vector2(1.4, 4),
              isContactGameOver: true,
            ),
            WallLine(
              Vector2(0, 1.8),
              Vector2(1.4, 1.8),
              isContactGameOver: true,
            ),
            WallLine(
              Vector2(1.6, 2.9),
              Vector2(3, 2.9),
              isContactGameOver: true,
            ),
          ],
        );
}
