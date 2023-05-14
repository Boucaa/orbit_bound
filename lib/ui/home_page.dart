import 'package:flutter/material.dart';
import 'package:space_balls/ui/levels_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/home.gif'),
              const SizedBox(height: 20),
              Text(
                'Space balls',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LevelsPage()),
                  );
                },
                child: const Text('Levels'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO: Add functionality for the second button
                },
                child: const Text('Level editor'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO: Add functionality for the third button
                },
                child: const Text('Educational portal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
