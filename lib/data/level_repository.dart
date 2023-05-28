import 'package:space_balls/data/levels/black_hole_merger_level.dart';
import 'package:space_balls/data/levels/kerr_level.dart';
import 'package:space_balls/data/levels/newtonian_level.dart';
import 'package:space_balls/data/levels/schwardschild_level.dart';
import 'package:space_balls/data/levels/slalom_level.dart';
import 'package:space_balls/data/levels/sun_with_planet_level.dart';
import 'package:space_balls/data/levels/test_level.dart';
import 'package:space_balls/data/levels/variable_gravity_level.dart';
import 'package:space_balls/model/game_level.dart';

class LevelRepository {
  static List<GameLevel Function()> get _levels => [
        () => TestLevel(),
        () => NewtonianLevel(),
        () => SunWithPlanetLevel(),
        () => SchwardschildLevel(),
        () => KerrLevel(),
        () => BlackHoleMergerLevel(),
        () => VariableGravityLevel(),
        () => SlalomLevel(),
      ];

  int get levelCount => _levels.length;

  GameLevel getLevel(int levelIndex) {
    return _levels[levelIndex]();
  }
}
