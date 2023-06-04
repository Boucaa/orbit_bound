import 'package:flame/game.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/newton_object.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/target.dart';

class NewtonianLevel extends GameLevel {
  NewtonianLevel()
      : super(
          id: 'newtonian',
          name: 'Newtonian object',
          description:
              'Orbits of test particles around a simple newtonian body are always cone-sections: circles, elipses, parabolas, or hyperbolas. Can you use these orbits, bend the shot, and hit the target?',
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
              mass: 2,
            ),
          ],
        );
}
