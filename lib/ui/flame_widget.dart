import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:space_balls/business/user_bloc.dart';
import 'package:space_balls/game/space_balls_game.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/ui/game_page.dart';
import 'package:space_balls/ui/level_description_dialog.dart';

final _log = Logger('FlameWidget');

class FlameWidget extends StatefulWidget {
  final GameLevel level;
  final int levelId;
  final bool showDescription;

  const FlameWidget({
    Key? key,
    required this.level,
    required this.levelId,
    required this.showDescription,
  }) : super(key: key);

  @override
  State<FlameWidget> createState() => _FlameWidgetState();
}

class _FlameWidgetState extends State<FlameWidget> {
  final GlobalKey _gameKey = GlobalKey();

  late final game = SpaceBallsGame(
    gameKey: _gameKey,
    level: widget.level,
    onWin: () {
      final userBloc = context.read<UserBloc>();
      final user = userBloc.state.user;

      if (user == null) return;

      final updatedUser = user.copyWith(
        completedLevelIds: {
          ...user.completedLevelIds,
          widget.level.id,
        },
      );

      userBloc.add(UpdateUser(updatedUser));

      showDialog(
        context: context,
        builder: (context) {
          TextButton nextLevelButton = TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              goToNextLevel();
            },
            child: const SizedBox(
              height: 40,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Next Level",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          );
          return AlertDialog(
            backgroundColor: Colors.grey[800],
            content: const Text(
              "You Win!",
              style: TextStyle(color: Colors.white, fontSize: 22),
              textAlign: TextAlign.center,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Center(child: nextLevelButton),
              ),
            ],
          );
        },
      );
    },
    onLose: () async {
      await Future.delayed(const Duration(milliseconds: 1000));
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            TextButton tryAgainButton = TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                reset();
              },
              child: const SizedBox(
                height: 40,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Try Again",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            );
            return AlertDialog(
              backgroundColor: Colors.grey[800],
              content: const Text(
                "You Lose",
                style: TextStyle(color: Colors.white, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Center(child: tryAgainButton),
                ),
              ],
            );
          },
        );
      }
    },
  );

  @override
  void initState() {
    if (widget.showDescription) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showDialog(
          context: context,
          builder: (context) => LevelDescriptionDialog(
            level: widget.level,
          ),
        );
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2D2D2D),
      child: Stack(
        children: [
          SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FittedBox(
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 3,
                  height: 3.0 * 16.0 / 9.0,
                  child: GameWidget(
                    game: game,
                    key: _gameKey,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  FloatingActionButton(
                    heroTag: 'back',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    tooltip: 'Back',
                    backgroundColor: Colors.deepOrange,
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    heroTag: 'reset',
                    onPressed: reset,
                    tooltip: 'Reset',
                    backgroundColor: Colors.blue,
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    heroTag: 'pause',
                    onPressed: () {
                      if (game.paused) {
                        setState(() {
                          game.paused = false;
                        });
                      } else {
                        setState(() {
                          game.paused = true;
                        });
                      }
                    },
                    tooltip: 'pause',
                    backgroundColor: !game.paused ? Colors.red : Colors.green,
                    child: Icon(
                      !game.paused ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),

                  const Spacer(), // Add this to fill remaining space
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      final user = state.user;
                      if (user != null &&
                          user.completedLevelIds.contains(widget.level.id)) {
                        return const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 36,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void reset() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GamePage(
          levelId: widget.levelId,
          showDescription: false,
        ),
      ),
    );
  }

  void goToNextLevel() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GamePage(
          levelId: widget.levelId + 1,
          showDescription: true,
        ),
      ),
    );
  }
}
