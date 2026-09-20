import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/newton_object.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/target.dart';
import 'package:vector_math/vector_math.dart';
import 'package:space_balls/l10n/app_localizations.dart';

class SunWithPlanetLevel extends GameLevel {
  SunWithPlanetLevel(AppLocalizations l10n)
      : super(
    id: 'sun_with_planet',
    name: l10n.sun_with_planet_name,
    description: l10n.sun_with_planet_description,
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
              initialPosition: Vector2(1, 3),
              mass: 1.5,
            ),
            NewtonObject(
              initialPosition: Vector2(2, 3),
              mass: 0.5,
              isStatic: false,
              initialVelocity: Vector2(0, -1),
            ),
          ],
        );
}
