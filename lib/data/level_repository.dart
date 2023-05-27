import 'package:flame/game.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/kerr_hole.dart';
import 'package:space_balls/model/newton_object.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/schwarzschild_hole.dart';
import 'package:space_balls/model/target.dart';
import 'package:space_balls/model/wall.dart';
import 'package:space_balls/model/variable_gravity_object.dart';

class LevelRepository {
  GameLevel getLevel(int levelId) {
    switch (levelId) {
      case 0:
        return GameLevel(
          name: 'Tutorial',
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
      case 1:
        return GameLevel(
          name: 'Newtonian object',
          description: 'Orbits of test particles around a simple newtonian body are always cone-sections: circles, elipses, parabolas, or hyperbolas. Can you use these orbits, bend the shot, and hit the target?',
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
      case 2:
        return GameLevel(
          name: 'sun with a planet',
          description: 'lorem ipsum',
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
      case 3:
        return GameLevel(
          name: 'Schwardschild black hole',
          description: 'The simplest black hole is a spherically symmetric static black hole called the Schwardschild black hole. Its gravity is so strong that a horizon exist where nothing can escape the immense force. Be careful so you dont fall in!',
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
      case 4:
        return GameLevel(
          name: 'Kerr black hole',
          description: 'Most black holes rotate. When a black hole rotates, there is a preferred direction of orbit where spacetime is wound up on the black hole. Effectively, you get slowed when orbiting against this inertial drag, and accelerated if you choose the right direction.',
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
      case 5:
        return GameLevel(
          name: 'Black hole merger',
          description: 'Mergers of black holes have opened a new observational window into the universe, can you navigate through such a merger?',
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
              initialVelocity: Vector2(0,0.8),
              isStatic: false,
            ),
            SchwardschildHole(
                initialPosition: Vector2(1, 3),
                mass: 1.5,
                isStatic: false,
                initialVelocity: Vector2(0,-0.8)
            ),
          ],
        );
      case 6:
        return GameLevel(
          name: 'Variable gravity object',
          description: 'What if gravity isnt as straightforward as we think it is? Explore the choice of exponent of a 1/r^n potential to hit the target.',
          gameObjects: [
            PlayerBall(
              mass: 1,
              initialVelocity: Vector2(-1, 0),
              initialPosition: Vector2(1.5, 4.8),
            ),
            Target(
              initialPosition: Vector2(1.5, 0.8),
            ),
            VariableGravityObject(
              initialPosition: Vector2(1.5, 3),
              mass: 1.5,
              exponent: 3,
            ),
            WallLine(
              Vector2(0, 3),
              Vector2(1.4, 3),
              isContactGameOver: true,
            ),
            WallLine(
              Vector2(1.6, 3),
              Vector2(2, 3),
              isContactGameOver: true,
            ),
            WallLine(
              Vector2(2.4, 3),
              Vector2(3, 3),
              isContactGameOver: true,
            ),
          ],
        );
      case 7:
        return GameLevel(
          name: 'Slalom',
          description: 'This level contains only simple newtonian objects with some bothersome barricades, can you take on the challenge?',
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
      default:
        throw Exception('Unknown level id: $levelId');
    }
  }
}
