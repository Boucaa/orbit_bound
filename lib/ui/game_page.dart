import 'package:flutter/material.dart';
import 'package:space_balls/data/level_repository.dart';
import 'package:space_balls/ui/flame_widget.dart';

class GamePage extends StatelessWidget {
  final int levelId;
  final bool showDescription;
  late final level = LevelRepository().getLevel(levelId);

  GamePage({
    Key? key,
    required this.levelId,
    this.showDescription = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlameWidget(
        level: level,
        levelId: levelId,
        showDescription: showDescription,
      ),
    );
  }
}
