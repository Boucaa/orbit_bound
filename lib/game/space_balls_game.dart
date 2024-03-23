import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame/particles.dart' as flame_particles;
import 'package:flame/particles.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:space_balls/game/components/ball_sprite_animation_component.dart';
import 'package:space_balls/game/components/ball_sprite_coponent.dart';
import 'package:space_balls/game/components/controls_component.dart';
import 'package:space_balls/game/contact/game_contact_listener.dart';
import 'package:space_balls/game/contact/lose_contact_resolver.dart';
import 'package:space_balls/game/contact/schwardschild_hole_contact_resolver.dart';
import 'package:space_balls/game/contact/win_contact_resolver.dart';
import 'package:space_balls/model/ball_object.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/wall.dart';

import '../model/game_object.dart';

final _log = Logger('SpaceBallsGame');

class SpaceBallsGame extends Forge2DGame {
  static const particleCount = 200;

  var frameCount = 0;
  final GameLevel level;
  bool gameOver = false;
  bool won = false;
  VoidCallback? onWin;
  VoidCallback? onLose;

  final GlobalKey gameKey;

  late PlayerBall player = level.gameObjects.firstWhere(
    (element) => element is PlayerBall,
  ) as PlayerBall;

  SpaceBallsGame({
    required this.level,
    required this.gameKey,
    this.onWin,
    this.onLose,
  }) : super(
          gravity: Vector2(0, 0),
          zoom: 1,
        );

  @override
  set paused(bool value) {
    if (gameOver) {
      return;
    }
    super.paused = value;
  }

  void shoot(Vector2 force) {
    player.shoot(
      force * 1.5,
    );
  }

  @override
  Future<void> onLoad() async {
    addAll(level.nonPhysicalComponents);
    await createGameObjects(level.gameObjects);
    addAll(createBoundaries());
    world.setContactListener(
      GameContactListener(
        contactResolvers: [
          WinContactResolver(onWin: win),
          LoseContactResolver(onLose: onGameOver),
          SchwardschildContactResolver(),
        ],
        onDeleteObjects: (objects) {
          for (var object in objects) {
            removeGameObject(object);
          }
        },
        onCreateObjects: (objects) {
          createGameObjects(objects);
        },
      ),
    );
    // TODO update this when the screen size changes or figure out a cleaner way
    RenderBox box = gameKey.currentContext!.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);
    add(
      ControlsComponent(
        onShoot: shoot,
        size: camera.viewport.effectiveSize,
        widgetStartOffset: Vector2(position.dx, position.dy),
      ),
    );
    return super.onLoad();
  }

  Future<void> createGameObjects(List<GameObject> gameObjects) async {
    addAll(gameObjects);
    addAll(
      await Future.wait(
        gameObjects.whereType<BallObject>().map(
              (e) => getBallObjectComponent(e),
            ),
      ).then((value) => value.whereType<Component>()),
    );
  }

  Future<Component?> getBallObjectComponent(BallObject ballObject) async {
    if (ballObject.customPaint) {
      return null;
    }
    if (ballObject.spriteSheetPath != null) {
      return BallSpriteAnimationComponent(
        ballObject: ballObject,
        img: await images.load(ballObject.spriteSheetPath!),
      );
    } else if (ballObject.spritePath != null) {
      return BallSpriteComponent(
        ballObject: ballObject,
        sprite: await loadSprite(ballObject.spritePath!),
      );
    } else {
      const defaultSpriteSheet = 'ball_default.png';
      return BallSpriteAnimationComponent(
        ballObject: ballObject,
        img: await images.load(defaultSpriteSheet),
      );
    }
  }

  void win() {
    _log.info('Win');
    won = true;
    removeGameObject(player);
    onWin?.call();
    // addLargeText('You won!');

    add(
      ParticleSystemComponent(
        particle: flame_particles.Particle.generate(
          count: particleCount,
          generator: (i) {
            final vec = randomVector2();

            // Generate random color for each particle
            final color = Colors.primaries[i % Colors.primaries.length];

            return AcceleratedParticle(
              acceleration: Vector2.zero(),
              speed: vec * 2.0,
              position: player.position + vec / 100.0,
              child: CircleParticle(
                paint: Paint()
                  ..color = color
                      .withAlpha((particleCount - i) * (255 ~/ particleCount)),
                radius: 0.02,
              ),
            );
          },
        ),
      ),
    );
  }

  Random rnd = Random();

  Vector2 randomVector2() {
    final vec = (Vector2.random(rnd) - Vector2.random(rnd)) * 10;
    return vec;
  }

  void onGameOver() {
    _log.info('Game over');
    gameOver = true;
    removeGameObject(player);

    add(
      ParticleSystemComponent(
        particle: flame_particles.Particle.generate(
          count: particleCount,
          generator: (i) {
            final vec = randomVector2();
            return AcceleratedParticle(
              acceleration: Vector2.zero(),
              speed: vec * 2.0,
              position: player.position + vec / 100.0,
              child: CircleParticle(
                paint: Paint()
                  ..color = Colors.black
                      .withBlue(i * (255 ~/ particleCount))
                      .withGreen((particleCount - i) * (255 ~/ particleCount)),
                radius: 0.02,
              ),
            );
          },
        ),
      ),
    );
    onLose?.call();
    // addLargeText('Game over');
  }

  void removeGameObject(GameObject gameObject) {
    remove(gameObject);
    removeWhere(
      (c) => c is BallSpriteAnimationComponent && c.ballObject == gameObject,
    );
  }

  List<Component> createBoundaries() {
    final topLeft = Vector2.all(WallLine.wallWidth / 2);
    final bottomRight = screenToWorld(camera.viewport.effectiveSize) - topLeft;
    final topRight = Vector2(bottomRight.x, topLeft.y);
    final bottomLeft = Vector2(topLeft.x, bottomRight.y);

    return [
      WallLine(topLeft, topRight),
      WallLine(topRight, bottomRight),
      WallLine(bottomLeft, bottomRight),
      WallLine(topLeft, bottomLeft)
    ];
  }

  @override
  void update(double dt) {
    frameCount++;
    // _log.fine('frame $frameCount with dt $dt');
    final objects = level.gameObjects;
    dt = 0.016;

    for (var i = 0; i < objects.length; i++) {
      if (objects[i].isStatic) {
        // newObjects.add(objects[i]);
        continue;
      }
      var acceleration = Vector2.zero();
      Vector2 calcAcceleration(Vector2 testPosition) {
        for (var j = 0; j < objects.length; j++) {
          if (i == j) {
            continue;
          }

          final objectA = objects[i];
          final objectB = objects[j];

          final interaction = objectB.calculateInteraction(objectA);
          acceleration += interaction;
        }
        return acceleration;
      }

      final velocityChange = calcAcceleration(objects[i].position) * dt;

      final newVelocity = objects[i].velocity + velocityChange;
      objects[i].body.linearVelocity = newVelocity;
    }

    super.update(dt);
  }

  void addLargeText(String text) {
    final style = TextStyle(color: BasicPalette.white.color, fontSize: 0.5);
    final regular = TextPaint(
      style: style,
    );
    add(
      TextComponent(
        text: text,
        anchor: Anchor.center,
        position: Vector2(
          camera.viewport.effectiveSize.x / 2,
          camera.viewport.effectiveSize.y / 2,
        ),
        textRenderer: regular,
      ),
    );
  }
}
