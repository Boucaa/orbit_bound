import 'package:flutter/cupertino.dart';
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
import 'package:space_balls/model/game_level.dart';

class LevelRepository {
  static List<GameLevel Function(BuildContext)> get _levels => [
        //() => TestLevel(),
        (context) => TutorialLevel(context),
        (context) => WallBounceLevel(context),
        (context) => NewtonianLevel(context),
        (context) => SunWithPlanetLevel(context),
        (context) => OrbitAroundLevel(context),
        (context) => SlalomLevel(context),
        (context) => SchwardschildLevel(context),
        (context) => KerrLevel(context),
        (context) => BlackHoleMergerLevel(context),
        (context) => VariableGravityLevel(context),
        (context) => NegativeMassLevel(context),
        (context) => FzuLevel(context),
      ];

  int get levelCount => _levels.length;

  GameLevel getLevel(int levelIndex, BuildContext context) {
    return _levels[levelIndex](context);
  }
}
