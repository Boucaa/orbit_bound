import 'package:space_balls/l10n/app_localizations.dart';
import 'package:space_balls/data/levels/black_hole_merger_level.dart';
import 'package:space_balls/data/levels/fzu_level.dart';
import 'package:space_balls/data/levels/kerr_level.dart';
import 'package:space_balls/data/levels/negative_mass_level.dart';
import 'package:space_balls/data/levels/newtonian_level.dart';
import 'package:space_balls/data/levels/orbit_around_level.dart';
import 'package:space_balls/data/levels/schwardschild_level.dart';
import 'package:space_balls/data/levels/slalom_level.dart';
import 'package:space_balls/data/levels/sun_with_planet_level.dart';
import 'package:space_balls/data/levels/tutorial_level.dart';
import 'package:space_balls/data/levels/variable_gravity_level.dart';
import 'package:space_balls/data/levels/wall_bounce_level.dart';
import 'package:space_balls/data/levels/wormhole_level.dart';
import 'package:space_balls/model/game_level.dart';

class LevelRepository {
  static List<GameLevel Function(AppLocalizations)> get _levels => [
        //() => TestLevel(),
        (l10n) => TutorialLevel(l10n),
        (l10n) => WallBounceLevel(l10n),
        (l10n) => NewtonianLevel(l10n),
        (l10n) => SunWithPlanetLevel(l10n),
        (l10n) => OrbitAroundLevel(l10n),
        (l10n) => SlalomLevel(l10n),
        (l10n) => SchwardschildLevel(l10n),
        (l10n) => KerrLevel(l10n),
        (l10n) => BlackHoleMergerLevel(l10n),
        (l10n) => VariableGravityLevel(l10n),
        (l10n) => NegativeMassLevel(l10n),
        (l10n) => FzuLevel(l10n),
        (l10n) => WormholeLevel(l10n),
      ];

  int get levelCount => _levels.length;

  GameLevel? getLevel(int levelIndex, AppLocalizations l10n) {
    if (levelIndex < 0 || levelIndex >= _levels.length) {
      return null;
    }
    return _levels[levelIndex](l10n);
  }
}
