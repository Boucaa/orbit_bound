import 'package:flame/game.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/newton_object.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/target.dart';
import 'package:space_balls/model/wall.dart';

class NegativeMassLevel extends GameLevel {
  NegativeMassLevel()
      : super(
    id: 'newtonian',
    name: 'Negative mass level',
    description:
    'How could the physics of negative mass objects work? You can also imagine you are dealing with motion of particles with the same charge. Can you hit the target?',
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
        initialPosition: Vector2(1.5, 3),
        mass: -2,
      ),
      WallLine(
        Vector2(2.5, 2),
        Vector2(2.5, 4),
        isContactGameOver: false,
      ),
      WallLine(
        Vector2(1.95, 2.45),
        Vector2(2.5, 2.45),
        isContactGameOver: true,
      ),
      WallLine(
        Vector2(1.95, 3.5),
        Vector2(2.5, 3.5),
        isContactGameOver: true,
      ),
      WallLine(
        Vector2(0, 3),
        Vector2(1.3, 3),
        isContactGameOver: true,
      ),
    ],
  );
}
