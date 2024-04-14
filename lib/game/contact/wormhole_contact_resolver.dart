import 'package:logging/logging.dart';
import 'package:space_balls/game/contact/game_contact_listener.dart';
import 'package:space_balls/model/game_object.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/wormhole.dart';

class WormholeContactResolver extends GameObjectContactResolver {
  final _log = Logger('WormholeContactResolver');

  WormholeContactResolver();

  @override
  GameObjectContactResolution resolveContact(
    GameObject objectA,
    GameObject objectB,
  ) {
    if (objectA is Wormhole && objectB is PlayerBall ||
        objectA is PlayerBall && objectB is Wormhole) {
      final player = (objectA is PlayerBall ? objectA : objectB) as PlayerBall;
      final Wormhole wormhole =
          (objectA is Wormhole ? objectA : objectB) as Wormhole;

      if (wormhole.target != null) {
        _log.fine('Teleporting player to wormhole target, current position: '
            '${player.position}, target position: ${wormhole.target!.position}, current velocity: ${player.velocity}');
        return GameObjectContactResolution(
          objectsToCreate: [
            PlayerBall(
              isStatic: false,
              mass: player.mass,
              initialPosition: wormhole.target!.position +
                  player.velocity.normalized() * wormhole.radius * 2.1,
              initialVelocity: player.velocity,
            ),
          ],
          objectsToDelete: [player],
        );
      }
    }
    return GameObjectContactResolution();
  }
}
