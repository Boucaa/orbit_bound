import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_balls/business/game_bloc.dart';
import 'package:space_balls/data/level_repository.dart';
import 'package:space_balls/ui/flame_widget.dart';

class GamePage extends StatelessWidget {
  final int levelId;
  late final level = LevelRepository().getLevel(levelId);

  GamePage({
    Key? key,
    required this.levelId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(
        level,
      ),
      child: FlameWidget(
        level: level,
        levelId: levelId,
      ),
    );
  }
}
