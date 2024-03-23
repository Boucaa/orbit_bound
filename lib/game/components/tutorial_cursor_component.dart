import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class TutorialCursorComponent extends SpriteComponent {
  TutorialCursorComponent()
      : super(
          sprite: Sprite(Flame.images.fromCache('cursor.webp')),
          size: Vector2.all(0.4),
        );

  void updateAnimation(Vector2 position, double opacity) {
    this.position = position + Vector2(0.1, 0.0);
    this.opacity = opacity;
  }
}
