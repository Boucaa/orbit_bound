import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:space_balls/model/game_object.dart';

/// Routes every contact the physics world reports to the [contactResolvers],
/// once per contact.
///
/// Forge2D's own dispatcher hands a contact to each side of it separately,
/// which would run a resolver twice for a single collision, so the events are
/// intercepted here instead of through [ContactCallbacks] on the bodies.
class GameContactListener extends ContactEventsDispatcher {
  late final List<GameObjectContactResolver> contactResolvers;
  late final void Function(List<GameObject> objects) onCreateObjects;
  late final void Function(List<GameObject> objects) onDeleteObjects;

  @override
  void beginContact(Contact contact) {
    final objects = contact.userDatas.whereType<GameObject>().toList();
    if (objects.length != 2) {
      return;
    }

    for (final resolver in contactResolvers) {
      final resolution = resolver.resolveContact(objects.first, objects.last);
      onCreateObjects(resolution.objectsToCreate);
      onDeleteObjects(resolution.objectsToDelete);
    }
  }
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
