import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_balls/data/level_repository.dart';
import 'package:space_balls/game/gravity.dart';
import 'package:space_balls/l10n/app_localizations_en.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/game_object.dart';
import 'package:space_balls/model/newton_object.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/schwarzschild_hole.dart';
import 'package:space_balls/model/wall.dart';

import 'physics_harness.dart';

/// The properties of the physics engine the game leans on, written out
/// directly rather than as recorded trajectories, so that a failure says what
/// broke instead of only that something moved.
void main() {
  GameLevel level(List<GameObject> objects) => GameLevel(
        id: 'behaviour',
        name: '',
        description: '',
        gameObjects: objects,
      );

  Future<PhysicsHarness> start(GameLevel gameLevel) =>
      initializeGame(() => PhysicsHarness(gameLevel));

  test('a ball with nothing pulling on it travels in a straight line',
      () async {
    final game = await start(
      level([
        PlayerBall(mass: 1, initialPosition: Vector2(1.5, 4.8)),
      ]),
    );
    game.shoot(Vector2(0, -1.5));
    const frames = 100;
    for (var i = 0; i < frames; i++) {
      game.update(fixedTimeStep);
    }

    // shoot() scales the force by 1.5, so the ball moves at 2.25 units/s.
    expect(
      game.player.position,
      closeToVector(Vector2(1.5, 4.8 - 2.25 * frames * fixedTimeStep), 0.001),
    );
    game.onRemove();
  });

  test('a ball bouncing off a wall keeps 80% of its speed', () async {
    final game = await start(
      level([
        PlayerBall(mass: 1, initialPosition: Vector2(1.5, 1.0)),
        WallLine(
          Vector2(1.0, 3.0),
          Vector2(2.0, 3.0),
          isContactGameOver: false,
        ),
      ]),
    );
    game.shoot(Vector2(0, 1.5));
    final speedBefore = game.player.velocity.length;

    for (var i = 0; i < 150; i++) {
      game.update(fixedTimeStep);
    }

    final velocityAfter = game.player.velocity;
    expect(velocityAfter.y, lessThan(0), reason: 'the ball did not bounce back');
    expect(velocityAfter.length / speedBefore, closeTo(0.8, 0.05));
    game.onRemove();
  });

  test('a ball launched at orbital speed stays in orbit', () async {
    const radius = 1.0;
    const centralMass = 1.0;
    final game = await start(
      level([
        PlayerBall(mass: 1, initialPosition: Vector2(1.5, 2.5 + radius)),
        NewtonObject(initialPosition: Vector2(1.5, 2.5), mass: centralMass),
      ]),
    );
    // v = sqrt(m / r) is the circular orbit speed for this gravity law, and
    // shoot() scales the force it is given by 1.5.
    game.shoot(Vector2(1.0, 0) * (1.0 / 1.5));

    var closest = double.infinity;
    var farthest = 0.0;
    for (var i = 0; i < 300; i++) {
      game.update(fixedTimeStep);
      final r = game.player.position.distanceTo(Vector2(1.5, 2.5));
      closest = r < closest ? r : closest;
      farthest = r > farthest ? r : farthest;
    }

    expect(closest, closeTo(radius, 0.03));
    expect(farthest, closeTo(radius, 0.03));
    game.onRemove();
  });

  test('the two black holes merge into one', () async {
    final game = await start(
      LevelRepository().getLevel(8, AppLocalizationsEn())!,
    );
    expect(game.children.whereType<SchwardschildHole>().length, 2);

    var mergedOnFrame = -1;
    for (var i = 0; i < 400; i++) {
      game.update(fixedTimeStep);
      await game.ready();
      if (mergedOnFrame < 0 &&
          game.children.whereType<SchwardschildHole>().length == 1) {
        mergedOnFrame = i;
      }
    }

    expect(mergedOnFrame, greaterThan(0), reason: 'the black holes never met');
    expect(mergedOnFrame, closeTo(180, 5));
    game.onRemove();
  });
}
