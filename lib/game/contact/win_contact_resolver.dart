import 'dart:ui';

import 'package:space_balls/game/contact/game_contact_listener.dart';
import 'package:space_balls/model/game_object.dart';

import '../../model/player_ball.dart';
import '../../model/target.dart';

class WinContactResolver extends GameObjectContactResolver {
  final VoidCallback onWin;

  WinContactResolver({
    required this.onWin,
  });

  @override
  GameObjectContactResolution resolveContact(
    GameObject objectA,
    GameObject objectB,
  ) {
    if (objectA is PlayerBall || objectB is PlayerBall) {
      if (objectA is Target || objectB is Target) {
        onWin();
      }
    }
    return GameObjectContactResolution();
  }
}
