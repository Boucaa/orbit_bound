import 'package:flutter/material.dart';

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
      content: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 22),
        textAlign: TextAlign.center,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Center(child: child),
        ),
      ],
    );
  }
}
