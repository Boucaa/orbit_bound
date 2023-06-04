import 'package:flame/game.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/schwarzschild_hole.dart';
import 'package:space_balls/model/target.dart';

class BlackHoleMergerLevel extends GameLevel {
  BlackHoleMergerLevel()
      : super(
          id: 'black_hole_merger',
          name: 'Black hole merger',
          description:
              'Mergers of black holes have opened a new observational window into the universe, can you navigate through such a merger?',
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
              initialPosition: Vector2(2, 3),
              mass: 1.5,
              initialVelocity: Vector2(0, 0.8),
              isStatic: false,
            ),
            SchwardschildHole(
              initialPosition: Vector2(1, 3),
              mass: 1.5,
              isStatic: false,
              initialVelocity: Vector2(0, -0.8),
            ),
          ],
        );
}
