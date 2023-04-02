import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_balls/business/game_bloc.dart';
import 'package:space_balls/ui/game.dart';

class GameBody extends StatelessWidget {
  const GameBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('space balls'),
      ),
      body: const Game(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (context.read<GameBloc>().state.isRunning) {
            context.read<GameBloc>().add(Stop());
          } else {
            context.read<GameBloc>().add(Start());
          }
        },
        tooltip: 'pause',
        backgroundColor: context.watch<GameBloc>().state.isRunning
            ? Colors.red
            : Colors.green,
        child: Icon(
          context.watch<GameBloc>().state.isRunning
              ? Icons.pause
              : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }
}
