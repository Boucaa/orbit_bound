import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_balls/business/user_bloc.dart';
import 'package:space_balls/ui/levels_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        final userBloc = context.read<UserBloc>();
                        userBloc.add(
                          UpdateUser(
                            userBloc.state.user!.copyWith(locale: 'cs'),
                          ),
                        );
                      },
                      child: const Text('🇨🇿', style: TextStyle(fontSize: 40)),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: () {
                        final userBloc = context.read<UserBloc>();
                        userBloc.add(
                          UpdateUser(
                            userBloc.state.user!.copyWith(locale: 'en'),
                          ),
                        );
                      },
                      child: const Text('🇬🇧', style: TextStyle(fontSize: 40)),
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
                SizedBox(
                  width: 250,
                  height: 250,
                  child: Image.asset(
                    'assets/images/home.gif',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Orbit Bound',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.levels,
                    style: TextStyle(fontSize: 18),
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
                // const SizedBox(height: 20),
                // OutlinedButton(
                //   onPressed: () {
                //     // TODO: Add functionality for the third button
                //   },
                //   style: OutlinedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(30),
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
