import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:space_balls/business/user_bloc.dart';
import 'package:space_balls/data/level_repository.dart';
import 'package:space_balls/ui/pages/game_page/game_page.dart';
import 'package:space_balls/ui/theme/colors.dart';
import 'package:space_balls/ui/theme/text_style.dart';

class LevelsPage extends StatelessWidget {
  const LevelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.levels),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.selectLevel,
                style: pageHeaderTextStyle,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1,
                    ),
                    itemCount: context.read<LevelRepository>().levelCount,
                    itemBuilder: (context, index) {
                      final level = context.read<LevelRepository>().getLevel(
                            index,
                            context,
                          );
                      return BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          final user = state.user; // Access the current user

                          return ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GamePage(
                                    levelId: index,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: user != null &&
                                      user.completedLevelIds.contains(level!.id)
                                  ? darkGreen
                                  : Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              (index + 1).toString(),
                              style: levelButtonTextStyle,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
