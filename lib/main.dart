import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:space_balls/business/base_provider.dart';
import 'package:space_balls/business/user_bloc.dart';
import 'package:space_balls/run_config.dart';
import 'package:space_balls/ui/pages/game_page/game_page.dart';
import 'package:space_balls/ui/pages/home_page/home_page.dart';
import 'package:space_balls/ui/theme/colors.dart';

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
    return BaseProvider(
      child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        return MaterialApp(
          title: 'Orbit Bound',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: primaryColor,
              brightness: Brightness.dark,
              primaryContainer: primaryColor,
              primary: Colors.white,
            ),
            appBarTheme: const AppBarTheme(
              color: primaryColor,
              foregroundColor: Colors.white,
            ),
            textTheme: GoogleFonts.oxaniumTextTheme(),
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('cs'),
          ],
          locale: Locale(state.user?.locale ?? 'en'),
          home: testLevel ? const GamePage(levelId: 0) : const HomePage(),
        );
      }),
    );
  }
}
