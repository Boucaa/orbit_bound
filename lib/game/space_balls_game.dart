import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:space_balls/game/ball_sprite_animation_component.dart';
import 'package:space_balls/game/ball_sprite_coponent.dart';
import 'package:space_balls/game/controls_component.dart';
import 'package:space_balls/model/ball_object.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/model/player_ball.dart';
import 'package:space_balls/model/target.dart';
import 'package:space_balls/ui/flame_widget.dart';

final _log = Logger('SpaceBallsGame');

class SpaceBallsGame extends Forge2DGame {
  var frameCount = 0;
  final GameLevel level;
  bool won = false;
  VoidCallback? onWin;

  SpaceBallsGame({
    required this.level,
    this.onWin,
  }) : super(
          gravity: Vector2(0, 0),
          zoom: 1,
        );

  void shoot(Vector2 force) {
    final playerBall = level.gameObjects.firstWhere(
      (element) => element is PlayerBall,
    ) as PlayerBall;

    playerBall.shoot(
      force * 1.5,
    );
  }

  @override
  Future<void> onLoad() async {
    addAll(level.gameObjects);
    addAll(
      await Future.wait(
        level.gameObjects.whereType<BallObject>().map(
          (e) async {
            if (e.spriteSheetPath != null) {
              return BallSpriteAnimationComponent(
                ballObject: e,
                img: await images.load(e.spriteSheetPath!),
              );
            } else if (e.spritePath != null) {
              return BallSpriteComponent(
                ballObject: e,
                sprite: await loadSprite(e.spritePath!),
              );
            } else {
              throw Exception('No sprite or sprite sheet path');
            }
          },
        ),
      ),
    );
    addAll(createBoundaries());
    world.setContactListener(
      TestContactListener(
        onPlayerContact: () {
          // _log.info('Player contact');
        },
        onWin: () {
          _log.info('Win');
          won = true;
          onWin?.call();
          addLargeText('You won!');
        },
      ),
    );
    // TODO update this when the screen size changes or figure out a cleaner way
    RenderBox box =
        FlameWidget.gameKey.currentContext!.findRenderObject() as RenderBox;
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

  List<Component> createBoundaries() {
    final topLeft = Vector2.zero();
    final bottomRight = screenToWorld(camera.viewport.effectiveSize);
    final topRight = Vector2(bottomRight.x, topLeft.y);
    final bottomLeft = Vector2(topLeft.x, bottomRight.y);

    return [
      Wall(topLeft, topRight),
      Wall(topRight, bottomRight),
      Wall(bottomLeft, bottomRight),
      Wall(topLeft, bottomLeft)
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

class Wall extends BodyComponent {
  final Vector2 _start;
  final Vector2 _end;

  Wall(this._start, this._end);

  @override
  Body createBody() {
    final shape = EdgeShape()..set(_start, _end);
    final fixtureDef = FixtureDef(shape, friction: 0.3);
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2.zero(),
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class TestContactListener extends ContactListener {
  final VoidCallback onPlayerContact;
  final VoidCallback onWin;

  TestContactListener({
    required this.onPlayerContact,
    required this.onWin,
  });

  @override
  void beginContact(Contact contact) {
    final fixtureA = contact.fixtureA;
    final fixtureB = contact.fixtureB;

    final bodyA = fixtureA.body;
    final bodyB = fixtureB.body;

    final objectA = bodyA.userData;
    final objectB = bodyB.userData;

    if (objectA is PlayerBall || objectB is PlayerBall) {
      onPlayerContact();
      if (objectA is Target || objectB is Target) {
        onWin();
      }
    }
  }

  @override
  void endContact(Contact contact) {}

  @override
  void postSolve(Contact contact, ContactImpulse impulse) {}

  @override
  void preSolve(Contact contact, Manifold oldManifold) {}
}
