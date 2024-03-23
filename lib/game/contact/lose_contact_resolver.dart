import 'dart:ui';

import 'package:space_balls/game/contact/game_contact_listener.dart';
import 'package:space_balls/model/game_object.dart';

import '../../model/player_ball.dart';

class LoseContactResolver extends GameObjectContactResolver {
  final VoidCallback onLose;

  LoseContactResolver({
    required this.onLose,
  });

  @override
  GameObjectContactResolution resolveContact(
    GameObject objectA,
    GameObject objectB,
  ) {
    if (objectA is PlayerBall || objectB is PlayerBall) {
      if (objectA.isContactGameOver || objectB.isContactGameOver) {
        onLose();
      }
    }
    return GameObjectContactResolution();
  }
}
