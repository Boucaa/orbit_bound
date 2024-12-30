import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:logging/logging.dart';
import 'package:space_balls/game/components/previous_shots_component.dart';

class ControlsComponent extends PositionComponent with DragCallbacks {
  final _log = Logger('ControlsComponent');

  final Function(
    Vector2 force,
    Vector2 startPosition,
    Vector2 endPosition,
  ) onShoot;

  Vector2? startPosition;
  bool tookAShot = false;
  String levelId;

  Vector2? get endPosition {
    if (startPosition == null ||
        endDevicePosition == null ||
        startDevicePosition == null) {
      return null;
    }
    final ratio = switch (startDevicePosition!.length) {
      0 => 1.0, // avoid division by zero
      double l => startPosition!.length / l,
    };

    return startPosition! - (startDevicePosition! - endDevicePosition!) * ratio;
  }

  // we need to use the device position, because the real canvas position is bugged for the update and end events
  Vector2? startDevicePosition;
  Vector2? endDevicePosition;
  final Vector2 widgetStartOffset;

  ControlsComponent({
    required this.onShoot,
    required super.size,
    required this.widgetStartOffset,
    required this.levelId,
  }) : super(priority: 100);

  @override
  FutureOr<void> onLoad() {
    add(
      ShotPreviewComponent(
        controlsComponent: this,
      ),
    );
    add(
      PreviousShotsComponent(levelId: levelId),
    );
    return super.onLoad();
  }

  @override
  void onDragStart(DragStartEvent event) {
    startPosition = event.canvasPosition;
    startDevicePosition = event.devicePosition - widgetStartOffset;
    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    endDevicePosition = event.devicePosition - widgetStartOffset;
    super.onDragUpdate(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (tookAShot) {
      return;
    }
    tookAShot = true;
    if (startPosition != null &&
        endDevicePosition != null &&
        startDevicePosition != null) {
      final force = startPosition! - endPosition!;
      onShoot(force, startPosition!, endPosition!);
      startPosition = null;
      startDevicePosition = null;
      endDevicePosition = null;
    }
    super.onDragEnd(event);
  }
}

class ShotPreviewComponent extends Component {
  final _log = Logger('ShotPreviewComponent');
  final ControlsComponent controlsComponent;
  final Random _random = Random();

  ShotPreviewComponent({
    required this.controlsComponent,
  }) : super(priority: 100);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (controlsComponent.tookAShot) {
      return;
    }
    if (controlsComponent.startPosition == null ||
        controlsComponent.endPosition == null) {
      return;
    }

    final startPosition = controlsComponent.startPosition!.toOffset();
    final endPosition = controlsComponent.endPosition!.toOffset();

    if (startPosition == endPosition) {
      return;
    }

    canvas.drawLine(
      startPosition,
      endPosition,
      Paint()
        ..color = const Color(0xFF00FF00) // The color of the photon trail.
        ..strokeWidth =
            0.03, // Adjust the thickness of the photon trail as needed.
    );

    // Calculate direction of the main line.
    final direction = endPosition - startPosition;
    final normalizedDirection = direction / direction.distance;

    // Perpendicular vector to the main line.
    final perpendicularVector =
        Offset(-normalizedDirection.dy, normalizedDirection.dx);

    // Draw particles along the line.
    const particleCount = 30;
    for (var i = 0; i < particleCount; ++i) {
      final t = i / (particleCount - 1);
      final position = Offset(
        lerpDouble(startPosition.dx, endPosition.dx, t)!,
        lerpDouble(startPosition.dy, endPosition.dy, t)!,
      );

      // Offset the particle position slightly from the main line.
      final sideOffset =
          perpendicularVector * (_random.nextDouble() * 0.06 - 0.03);

      // Draw a small streak as the particle.
      final offsetLength = _random.nextDouble() * 0.04;
      final offset = normalizedDirection * offsetLength;
      final particleStart = position + sideOffset - offset;
      final particleEnd = position + sideOffset + offset;

      // Generate a color that transitions from green to white.
      final colorRnd = _random.nextInt(256);
      final color = Color.fromRGBO(
        colorRnd,
        255,
        colorRnd,
        _random.nextDouble(), // alpha
      );

      canvas.drawLine(
        particleStart,
        particleEnd,
        Paint()
          ..strokeWidth = 0.02
          ..color = color,
      );
    }
  }
}
