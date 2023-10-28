import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/newton_object.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/target.dart';
import 'package:space_balls/model/wall.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrbitAroundLevel extends GameLevel {
  OrbitAroundLevel(BuildContext context)
      : super(
    id: 'orbitaround',
    name: AppLocalizations.of(context)!.orbitaround_name,
    description: AppLocalizations.of(context)!.orbitaround_description,
    gameObjects: [
            PlayerBall(
              mass: 1,
              initialVelocity: Vector2(-1, 0),
              initialPosition: Vector2(2, 4.8),
            ),
            Target(
              initialPosition: Vector2(1, 4.8),
            ),
            NewtonObject(
              initialPosition: Vector2(1.5, 3),
              mass: 1.5,
            ),
            WallLine(
              Vector2(1.5, 3.2),
              Vector2(1.5, 5),
              isContactGameOver: true,
            ),
          ],
        );
}
