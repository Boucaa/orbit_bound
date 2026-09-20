import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:space_balls/data/level_repository.dart';
import 'package:space_balls/l10n/app_localizations_en.dart';

import 'physics_harness.dart';

/// Regression test for the physics engine itself.
///
/// The goldens were recorded on forge2d 0.13 (the pure-Dart Box2D v2 port);
/// they exist so that swapping the engine underneath can be checked against
/// how the game used to play. Box2D v3 is a different solver, so exact
/// equality is not expected - what has to hold is that the same shot still
/// flies the same path and the level still ends the same way.
///
/// Regenerate with:
///   UPDATE_PHYSICS_GOLDENS=1 flutter test test/physics
void main() {
  /// How far a sampled position may drift, in world units. The world is 3
  /// units wide, so this is ~1% of the screen - far below what a player could
  /// notice, and far below what would change whether a level is solvable.
  const positionTolerance = 0.03;

  /// How many frames later or earlier a level may be won or lost.
  const outcomeFrameTolerance = 3;

  final goldenFile = File('test/physics/goldens/trajectories.json');
  final updating = Platform.environment['UPDATE_PHYSICS_GOLDENS'] == '1';
  final recorded = <String, dynamic>{};

  final golden = goldenFile.existsSync()
      ? jsonDecode(goldenFile.readAsStringSync()) as Map<String, dynamic>
      : <String, dynamic>{};

  final repository = LevelRepository();
  final l10n = AppLocalizationsEn();

  for (var index = 0; index < repository.levelCount; index++) {
    final levelId = repository.getLevel(index, l10n)!.id;

    final levelShots = {...shots, ...?targetedShots[levelId]};

    for (final shot in levelShots.entries) {
      test('$levelId - ${shot.key} shot', () async {
        // The level is rebuilt per shot: game objects hold live physics bodies.
        final level = repository.getLevel(index, l10n)!;
        final actual = await runShot(level, shot.value.clone());
        final key = '$levelId.${shot.key}';

        if (updating) {
          recorded[key] = actual.toJson();
          return;
        }

        final expected = Trajectory.fromJson(
          golden[key] as Map<String, dynamic>? ??
              (throw StateError('No golden for $key, regenerate them')),
        );

        expect(
          actual.outcome,
          expected.outcome,
          reason: 'the level ends differently than it used to',
        );
        expect(
          actual.outcomeFrame,
          closeTo(expected.outcomeFrame, outcomeFrameTolerance),
          reason: 'the level ends at a different time than it used to',
        );
        expect(
          actual.maxDeviationFrom(expected),
          lessThan(positionTolerance),
          reason: 'the ball flies a different path than it used to',
        );
      });
    }
  }

  tearDownAll(() {
    if (!updating) {
      return;
    }
    goldenFile.writeAsStringSync(
      '${const JsonEncoder.withIndent('  ').convert(recorded)}\n',
    );
  });
}
