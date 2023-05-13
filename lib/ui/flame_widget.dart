import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:space_balls/game/space_balls_game.dart';

class FlameWidget extends StatefulWidget {
  const FlameWidget({Key? key}) : super(key: key);

  @override
  State<FlameWidget> createState() => _FlameWidgetState();
}

class _FlameWidgetState extends State<FlameWidget> {
  final game = SpaceBallsGame();

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: game);
  }
}
