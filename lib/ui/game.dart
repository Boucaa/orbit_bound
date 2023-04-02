import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_balls/business/game_bloc.dart';

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Container(
          color: Colors.black,
          child: Stack(
            children: state.objects.map((object) {
              return Positioned(
                left: object.position.x,
                top: object.position.y,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
