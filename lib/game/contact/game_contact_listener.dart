import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:space_balls/model/game_object.dart';

class GameContactListener extends ContactListener {
  final List<GameObjectContactResolver> contactResolvers;
  final Function(List<GameObject> object) onCreateObjects;
  final Function(List<GameObject> object) onDeleteObjects;

  GameContactListener({
    required this.contactResolvers,
    required this.onCreateObjects,
    required this.onDeleteObjects,
  });

  @override
  void beginContact(Contact contact) {
    final fixtureA = contact.fixtureA;
    final fixtureB = contact.fixtureB;

    final bodyA = fixtureA.body;
    final bodyB = fixtureB.body;

    final objectA = bodyA.userData;
    final objectB = bodyB.userData;

    if (objectA is! GameObject || objectB is! GameObject) {
      return;
    }

    for (final resolver in contactResolvers) {
      final resolution = resolver.resolveContact(objectA, objectB);
      onCreateObjects(resolution.objectsToCreate);
      onDeleteObjects(resolution.objectsToDelete);
    }
  }

  @override
  void endContact(Contact contact) {}

  @override
  void postSolve(Contact contact, ContactImpulse impulse) {}

  @override
  void preSolve(Contact contact, Manifold oldManifold) {}
}

abstract class GameObjectContactResolver {
  GameObjectContactResolution resolveContact(
    GameObject objectA,
    GameObject objectB,
  );
}

class GameObjectContactResolution {
  final List<GameObject> objectsToDelete;
  final List<GameObject> objectsToCreate;

  GameObjectContactResolution({
    this.objectsToDelete = const [],
    this.objectsToCreate = const [],
  });
}
