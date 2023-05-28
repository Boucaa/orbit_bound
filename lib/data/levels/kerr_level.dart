import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/kerr_hole.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/target.dart';
import 'package:vector_math/vector_math_64.dart';

class KerrLevel extends GameLevel {
  KerrLevel()
      : super(
          id: 'kerr',
          name: 'Kerr black hole',
          description:
              'Most black holes rotate. When a black hole rotates, there is a preferred direction of orbit where spacetime is wound up on the black hole. Effectively, you get slowed when orbiting against this inertial drag, and accelerated if you choose the right direction.',
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
