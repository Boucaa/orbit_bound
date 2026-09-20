import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/widgets.dart';
import 'package:space_balls/data/shot/shot_bloc.dart';
import 'package:space_balls/game/gravity.dart';
import 'package:space_balls/game/space_balls_game.dart';
import 'package:space_balls/model/ball_object.dart';
import 'package:space_balls/model/game_level.dart';

/// Runs the real game against the real physics engine without a widget tree.
///
/// Sprites, level decoration and the drag controls are dropped: they need
/// assets or a `RenderBox`, and none of them can move a body.
class PhysicsHarness extends SpaceBallsGame {
  PhysicsHarness(GameLevel level)
      : super(
          level: GameLevel(
            id: level.id,
            name: level.name,
            description: level.description,
            gameObjects: level.gameObjects,
          ),
          gameKey: GlobalKey(),
          shotBloc: ShotBloc(),
        );

  @override
  void addControls() {}

  @override
  Future<Component?> getBallObjectComponent(BallObject ballObject) async =>
      null;
}

enum Outcome { win, lose, running }

/// A recorded run: where the player went, and how the level ended.
class Trajectory {
  Trajectory({
    required this.samples,
    required this.outcome,
    required this.outcomeFrame,
  });

  factory Trajectory.fromJson(Map<String, dynamic> json) => Trajectory(
        samples: [
          for (final p in json['samples'] as List)
            Vector2((p as List)[0] as double, p[1] as double),
        ],
        outcome: Outcome.values.byName(json['outcome'] as String),
        outcomeFrame: json['outcomeFrame'] as int,
      );

  final List<Vector2> samples;
  final Outcome outcome;

  /// The frame the level was won or lost on, or -1 if it was still running.
  final int outcomeFrame;

  Map<String, dynamic> toJson() => {
        'outcome': outcome.name,
        'outcomeFrame': outcomeFrame,
        'samples': [
          for (final s in samples)
            [_round(s.x), _round(s.y)],
        ],
      };

  static double _round(double v) => double.parse(v.toStringAsFixed(6));

  /// The largest distance between two runs at the same sample index, over
  /// the part both of them cover.
  ///
  /// A run that ends a sample earlier or later is caught by [outcomeFrame]
  /// instead, so that a few frames of timing difference does not also show up
  /// here as an enormous position error.
  double maxDeviationFrom(Trajectory other) {
    var worst = 0.0;
    final shared = samples.length < other.samples.length
        ? samples.length
        : other.samples.length;
    for (var i = 0; i < shared; i++) {
      final d = samples[i].distanceTo(other.samples[i]);
      if (d > worst) {
        worst = d;
      }
    }
    return worst;
  }
}

/// Fires [force] on [level] and steps the physics for [frames] fixed steps,
/// recording the player position every [sampleEvery] frames.
Future<Trajectory> runShot(
  GameLevel level,
  Vector2 force, {
  int frames = 300,
  int sampleEvery = 5,
}) async {
  final game = await initializeGame(() => PhysicsHarness(level));
  final samples = <Vector2>[];
  var outcome = Outcome.running;
  var outcomeFrame = -1;

  game.shoot(force);
  for (var frame = 0; frame < frames; frame++) {
    game.update(fixedTimeStep);
    // Bodies created mid-run (wormhole exits, merged black holes) only mount
    // once their async load has had a turn of the event loop.
    await game.ready();

    if (game.won || game.gameOver) {
      outcome = game.won ? Outcome.win : Outcome.lose;
      outcomeFrame = frame;
      break;
    }
    if (frame % sampleEvery == 0) {
      samples.add(game.player.position.clone());
    }
  }

  game.onRemove();
  return Trajectory(
    samples: samples,
    outcome: outcome,
    outcomeFrame: outcomeFrame,
  );
}

/// The fan of shots every level is probed with, at a power a player would
/// realistically use. Angles are degrees off straight up.
final shots = <String, Vector2>{
  'left45': _shot(-45),
  'left20': _shot(-20),
  'up': _shot(0),
  'right20': _shot(20),
  'right45': _shot(45),
};

/// Shots that exist to drive a level's own mechanic, which the generic fan
/// happens to miss.
final targetedShots = <String, Map<String, Vector2>>{
  // Straight into the entry wormhole, so that the teleport is exercised.
  'wormhole': {'into_wormhole': Vector2(0.671, -1.342)},
};

Vector2 _shot(double degrees) {
  const power = 1.5;
  final radians = degrees * pi / 180;
  return Vector2(sin(radians), -cos(radians)) * power;
}
