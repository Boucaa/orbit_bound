import 'package:space_balls/game/contact/game_contact_listener.dart';
import 'package:space_balls/model/game_object.dart';
import 'package:space_balls/model/schwarzschild_hole.dart';

class SchwardschildContactResolver extends GameObjectContactResolver {
  SchwardschildContactResolver();

  @override
  GameObjectContactResolution resolveContact(
    GameObject objectA,
    GameObject objectB,
  ) {
    if (objectA is SchwardschildHole && objectB is SchwardschildHole) {
      return GameObjectContactResolution(
        objectsToDelete: [objectA, objectB],
        objectsToCreate: [
          SchwardschildHole(
            initialPosition: (objectA.position + objectB.position) / 2,
            mass: objectA.mass + objectB.mass,
            radius: objectA.radius + objectB.radius,
          ),
        ],
      );
    }
    return GameObjectContactResolution();
  }
}
