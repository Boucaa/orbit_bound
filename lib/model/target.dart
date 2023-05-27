import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:space_balls/model/ball_object.dart';
import 'package:space_balls/model/game_object.dart';

class Target extends BallObject {
  Target({
    required super.initialPosition,
  }) : super(
          mass: 1,
          isStatic: true,
          radius: 0.25,
          // spritePath: 'portalv2.png',
          isContactGameOver: false,
          customPaint: true,
        );

  // A value between 0.0 and 1.0 representing the current animation state.
  double animationValue = 0.0;

  @override
  Vector2 calculateInteraction(GameObject other) {
    return Vector2.zero();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update the animation value. The speed of the animation can be adjusted by changing the value added to animationValue.
    animationValue = (animationValue + dt * 0.5) % 1.0;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Draw an outer glow that pulses
    final pulseRadius =
        radius + 0.03 + 0.02 * sin(animationValue * 2 * pi); // Pulsating effect
    final outerGlow = Paint()
      ..color = Colors.cyan.withOpacity(1); // Half-transparent white
    canvas.drawCircle(Offset.zero, pulseRadius, outerGlow);
    // Create a gradient that cycles through different colors
    final gradient = SweepGradient(
      colors: const [
        Colors.blue,
        Colors.purple,
        Colors.blue,
        Colors.purple,
        Colors.blue,
        Colors.purple,
        Colors.blue,
        Colors.purple,
        Colors.blue,
        // Repeat the first color at the end for a smooth transition
      ],
      stops: const [
        0.0,
        0.125,
        0.25,
        0.375,
        0.5,
        0.625,
        0.75,
        0.875,
        1.0,
      ],
      transform: GradientRotation(
          animationValue * 2 * pi), // Animate the rotation of the gradient
    ).createShader(
      Rect.fromCircle(
        center: Offset.zero,
        radius: radius,
      ),
    );

    // Apply the gradient to the paint
    final paint = Paint()..shader = gradient;

    // Draw a circle with the gradient
    canvas.drawCircle(Offset.zero, radius, paint);
  }
}
