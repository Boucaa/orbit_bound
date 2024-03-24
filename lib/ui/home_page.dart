import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:space_balls/ui/levels_page.dart';
import 'package:space_balls/ui/locale_flag_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    LocaleFlagButton(
                      asset: 'assets/images/flag_cz.svg',
                      locale: 'cs',
                    ),
                    SizedBox(width: 12),
                    LocaleFlagButton(
                      asset: 'assets/images/flag_gb.svg',
                      locale: 'en',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   width: 250,
                //   height: 250,
                //   child: Image.asset(
                //     'assets/images/home.gif',
                //     fit: BoxFit.cover,
                //   ),
                // ),
                const SizedBox(height: 20),
                // Replace the title text with the image
                Image.asset(
                  'assets/images/title.webp',
                  width: 340, // Adjust width as needed
                  height: 340, // Adjust height as needed
                ),
                // const Text(
                //   'Orbit Bound',
                //   style: TextStyle(
                //     fontSize: 40,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white,
                //   ),
                // ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LevelsPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.levels,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                // const SizedBox(height: 20),
                // OutlinedButton(
                //   onPressed: () {
                //     // TODO: Add functionality for the second button
                //   },
                //   style: OutlinedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(30),
                //     ),
                //   ),
                //   child: const Text(
                //     'Level Editor',
                //     style: TextStyle(fontSize: 18),
                //   ),
                // ),
                const SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () {
                //     // TODO: Add functionality for the third button
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor:
                //     Theme.of(context).colorScheme.primaryContainer,
                //     padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //   ),
                //   child: const Text(
                //     'Educational Portal',
                //     style: TextStyle(fontSize: 18),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
