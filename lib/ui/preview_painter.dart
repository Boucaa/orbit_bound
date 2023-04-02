import 'dart:ui';

import 'package:flutter/material.dart';

class PreviewPainter extends CustomPainter {
  final List<Offset> points;

  const PreviewPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    const pointMode = PointMode.lines;
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}
