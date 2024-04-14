import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/game_object.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/target.dart';
import 'package:space_balls/model/wall.dart';
import 'package:space_balls/model/wormhole.dart';

class WormholeLevel extends GameLevel {
  WormholeLevel(BuildContext context)
      : super(
          id: 'wormhole',
          name: AppLocalizations.of(context)!.wormhole_name,
          description: AppLocalizations.of(context)!.wormhole_description,
          gameObjects: buildObjects(),
        );

  static List<GameObject> buildObjects() {
    final wormholeStart = Wormhole(
      initialPosition: Vector2(2.15, 3.5),
    );

    final wormholeEnd = Wormhole(
      initialPosition: Vector2(1.2, 1.8),
    );

    wormholeStart.setTarget(wormholeEnd);

    return [
      PlayerBall(
        mass: 1,
        initialVelocity: Vector2(-1, 0),
        initialPosition: Vector2(1.5, 4.8),
      ),
      Target(
        initialPosition: Vector2(2.2, 0.7),
      ),
      wormholeStart,
      wormholeEnd,
      WallLine(
        Vector2(0.5, 3.5),
        Vector2(2.5, 1.5),
        isContactGameOver: true,
      ),
    ];
  }
}
