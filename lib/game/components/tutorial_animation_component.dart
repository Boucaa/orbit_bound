import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:space_balls/game/components/tutorial_cursor_component.dart';

class TutorialAnimationComponent extends Component {
  static const baseYPos = 3.5;
  static const initialRadius = 0.2;
  static const finalRadius = 0.1;

  TutorialCursorComponent? _cursorComponent;
  double _animationValue = 0.0;

  @override
  FutureOr<void> onLoad() async {
    await findGame()!.images.load('cursor.webp');
    _cursorComponent = TutorialCursorComponent();
    add(_cursorComponent!);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _animationValue = (_animationValue + dt * 0.5) % 1.0;
  }

  @override
  void render(Canvas canvas) {
    Paint paint = Paint()..color = Colors.white;

    double x = 2;

    if (_animationValue <= 1.0 / 3.0) {
      double phaseProgress = _animationValue / (1.0 / 3.0);
      double sizeFactor = 1 - phaseProgress;
      double currentRadius =
          finalRadius + (initialRadius - finalRadius) * sizeFactor;
      final opacity = phaseProgress;
      paint.color = Color.fromRGBO(255, 255, 255, opacity);

      final position = Vector2(x, baseYPos);

      canvas.drawCircle(position.toOffset(), currentRadius, paint);
      _cursorComponent?.updateAnimation(position, opacity);
    } else if (_animationValue <= 2.0 / 3.0) {
      double phaseProgress = (_animationValue - 1.0 / 3.0) / (1.0 / 3.0);
      final yPos = phaseProgress * 1;

      final position = Vector2(x, baseYPos + yPos);

      canvas.drawCircle(
        position.toOffset(),
        finalRadius,
        paint,
      );
      _cursorComponent?.updateAnimation(position, 1);
    } else {
      double phaseProgress = (_animationValue - 2.0 / 3.0) / (1.0 / 3.0);
      double currentRadius =
          finalRadius + (initialRadius - finalRadius) * phaseProgress;
      final opacity = 1 - phaseProgress;
      paint.color = Color.fromRGBO(255, 255, 255, opacity);

      final position = Vector2(x, baseYPos + 1);
      canvas.drawCircle(
        position.toOffset(),
        currentRadius,
        paint,
      );
      _cursorComponent?.updateAnimation(position, opacity);
    }
  }
}
