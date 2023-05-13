import 'package:flame/game.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/target.dart';

class LevelRepository {
  GameLevel getLevel(int levelId) {
    switch (levelId) {
      case 0:
        return GameLevel(
          name: 'test',
          description: 'lorem ipsum',
          gameObjects: [
            PlayerBall(
              mass: 1,
              initialVelocity: Vector2(-1, 0),
              initialPosition: Vector2(2, 4),
            ),
            Target(
              initialPosition: Vector2(3, 1),
            ),
            // NewtonObject(
            //   initialPosition: Vector2(4 / 3, 8 / 3),
            //   mass: 5,
            // ),
          ],
        );
      default:
        throw Exception('Unknown level id: $levelId');
    }
  }
}
