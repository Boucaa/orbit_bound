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
    final level = context.read<LevelRepository>().getLevel(levelId, context);
    if (level == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
      return Container();
    }
    return Scaffold(
      body: FlameWidget(
        level: level,
        levelId: levelId,
        showDescription: showDescription,
      ),
    );
  }
}
