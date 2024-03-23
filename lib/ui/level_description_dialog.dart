import 'package:flutter/material.dart';
import 'package:space_balls/model/game_level.dart';

class LevelDescriptionDialog extends StatelessWidget {
  final GameLevel level;

  const LevelDescriptionDialog({
    Key? key,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFF2D2D2D),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  level.name,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 20),
                Text(
                  level.description,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
