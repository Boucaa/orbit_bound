import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:space_balls/game/space_balls_game.dart';
import 'package:space_balls/model/game_level.dart';

class FlameWidget extends StatefulWidget {
  final GameLevel level;

  const FlameWidget({
    Key? key,
    required this.level,
  }) : super(key: key);

  @override
  State<FlameWidget> createState() => _FlameWidgetState();
}

class _FlameWidgetState extends State<FlameWidget> {
  late final game = SpaceBallsGame(
    level: widget.level,
  );

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: game);
  }
}
