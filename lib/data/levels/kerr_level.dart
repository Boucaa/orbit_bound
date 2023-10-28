import 'package:flutter/widgets.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/kerr_hole.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/target.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class KerrLevel extends GameLevel {
  KerrLevel(BuildContext context)
      : super(
          id: 'kerr',
          name: AppLocalizations.of(context)!.kerr_name,
          description: AppLocalizations.of(context)!.kerr_description,
          gameObjects: [
            PlayerBall(
              mass: 1,
              initialVelocity: Vector2(-1, 0),
              initialPosition: Vector2(1.5, 4.8),
            ),
            Target(
              initialPosition: Vector2(1.5, 0.8),
            ),
            KerrHole(
              initialPosition: Vector2(1.5, 3),
              mass: 1.5,
              spin: 1,
              drag: 3,
            ),
          ],
        );
}
