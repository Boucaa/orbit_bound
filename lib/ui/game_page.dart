import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_balls/business/game_bloc.dart';
import 'package:space_balls/ui/flame_widget.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc()..add(Start()),
      child: const FlameWidget(),
    );
  }
}
