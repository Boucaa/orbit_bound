import 'package:flutter/material.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/ui/base_dialog.dart';

class LevelDescriptionDialog extends StatelessWidget {
  final GameLevel level;

  const LevelDescriptionDialog({
    super.key,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: BaseDialog(
        title: level.name,
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
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
