import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:space_balls/ui/game_page.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print(
      '${record.level.name}/${record.loggerName}: ${record.time}: ${record.message}',
    );
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GamePage(levelId: 0),
    );
  }
}
