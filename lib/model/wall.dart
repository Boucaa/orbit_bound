import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:space_balls/model/game_object.dart';

class WallLine extends GameObject {
  final Vector2 _start;
  final Vector2 _end;

  WallLine(
    this._start,
    this._end, {
    super.isContactGameOver = true,
  }) : super(
          mass: 0.0,
          isStatic: true,
        );

  @override
  Body createBody() {
    final shape = EdgeShape()..set(_start, _end);
    final fixtureDef = FixtureDef(shape, friction: 0.0);
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2.zero(),
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  Vector2 calculateInteraction(GameObject other) {
    return Vector2.zero();
  }

  @override
  void render(Canvas canvas) {
    // Apply a gradient depending on the danger state
    final gradient = isContactGameOver
        ? const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.red, Colors.orange], // Changed black to orange
            stops: [0.0, 1.0],
          ).createShader(
            Rect.fromPoints(
              Offset(_start.x, _start.y),
              Offset(_end.x, _end.y),
            ),
          )
        : const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.blue, Colors.purple],
            stops: [0.0, 1.0],
          ).createShader(
            Rect.fromPoints(
              Offset(_start.x, _start.y),
              Offset(_end.x, _end.y),
            ),
          );

    // Apply the gradient to the paint
    final paint = Paint()
      ..shader = gradient
      ..strokeWidth = 0.05 // reduced strokeWidth for smaller world size
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // gives a rounded cap to the line ends

    // Draw a line with the gradient
    canvas.drawLine(
      Offset(_start.x, _start.y),
      Offset(_end.x, _end.y),
      paint,
    );

    super.render(canvas);
  }
}
