import 'package:flame/components.dart';

class ShotRepository {
  final Map<String, List<Shot>> _shots = {};

  void addShot(String levelId, Shot shot) {
    if (_shots[levelId] == null) {
      _shots[levelId] = [];
    }
    _shots[levelId]!.add(shot);
    if (_shots[levelId]!.length > 3) {
      _shots[levelId]!.removeAt(0);
    }
  }

  List<Shot> getShots(String levelId) {
    return _shots[levelId] ?? [];
  }
}

class Shot {
  final Vector2 start;
  final Vector2 end;

  Shot({
    required this.start,
    required this.end,
  });
}
