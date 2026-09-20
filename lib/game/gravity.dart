import 'package:space_balls/model/game_object.dart';
import 'package:vector_math/vector_math.dart';

/// The physics engine is stepped with this instead of the real frame time, so
/// that trajectories are reproducible and independent of the frame rate.
const fixedTimeStep = 0.016;

/// The game integrates gravity itself: every step each non-static object's
/// velocity is updated from the pull of all the others, and the physics engine
/// only moves the bodies along that velocity.
void applyGravity(List<GameObject> objects, double dt) {
  for (var i = 0; i < objects.length; i++) {
    if (objects[i].isStatic) {
      continue;
    }
    var acceleration = Vector2.zero();
    for (var j = 0; j < objects.length; j++) {
      if (i == j) {
        continue;
      }
      acceleration += objects[j].calculateInteraction(objects[i]);
    }
    objects[i].body.linearVelocity = objects[i].velocity + acceleration * dt;
  }
}
