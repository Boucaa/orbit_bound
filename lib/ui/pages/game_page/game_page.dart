import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_balls/data/level_repository.dart';
import 'package:space_balls/ui/pages/game_page/widgets/flame_widget.dart';

class GamePage extends StatelessWidget {
  final bool showDescription;
  final int levelId;

  const GamePage({
    super.key,
    required this.levelId,
    this.showDescription = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlameWidget(
        level: context.read<LevelRepository>().getLevel(levelId, context),
        levelId: levelId,
        showDescription: showDescription,
      ),
    );
  }
}
