import 'package:flutter/material.dart';
import 'package:space_balls/model/game_level.dart';
import 'package:space_balls/ui/widgets/base_dialog.dart';
import 'package:space_balls/ui/theme/text_style.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                level.description,
                style: baseTextStyle,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
