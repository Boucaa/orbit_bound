import 'package:flame/game.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/newton_object.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/target.dart';
import 'package:space_balls/model/wall.dart';

class TestLevel extends GameLevel {
  TestLevel()
      : super(
          id: 'test',
          name: 'test',
          description: 'lorem ipsum',
          gameObjects: [
            PlayerBall(
              mass: 1,
              initialVelocity: Vector2(-1, 0),
              initialPosition: Vector2(2, 4),
            ),
            Target(
              initialPosition: Vector2(2.5, 1),
            ),
            NewtonObject(
              initialPosition: Vector2(1, 4.5),
              mass: 1,
            ),
            WallLine(
              Vector2(1.5, 1.5),
              Vector2(2.0, 2.0),
              isContactGameOver: false,
            ),
            WallLine(
              Vector2(1.0, 1.5),
              Vector2(1.5, 2.0),
              isContactGameOver: true,
            ),
          ],
        );
}
