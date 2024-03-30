import 'package:flutter/material.dart';
import 'package:space_balls/ui/theme/text_style.dart';

class BaseDialog extends StatelessWidget {
  final Widget child;
  final String title;

  const BaseDialog({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: dialogHeaderTextStyle,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Center(child: child),
          ),
        ],
      ),
    );
  }
}
