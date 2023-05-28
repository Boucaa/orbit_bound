import 'package:flame/game.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/schwarzschild_hole.dart';
import 'package:space_balls/model/target.dart';

class SchwardschildLevel extends GameLevel {
  SchwardschildLevel()
      : super(
          id: 'schwardschild',
          name: 'Schwardschild black hole',
          description:
              'The simplest black hole is a spherically symmetric static black hole called the Schwardschild black hole. Its gravity is so strong that a horizon exist where nothing can escape the immense force. Be careful so you dont fall in!',
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
