import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/painting.dart';
import 'package:space_balls/data/shot/shot_bloc.dart';
import 'package:space_balls/model/shot.dart';

class PreviousShotsComponent extends Component
    with FlameBlocReader<ShotBloc, ShotState> {
  final String levelId;
  List<Shot> previousShots = [];

  PreviousShotsComponent({
    required this.levelId,
  }) : super(priority: 100);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    for (final shot in previousShots) {
      canvas.drawLine(
        shot.start.toOffset(),
        shot.end.toOffset(),
        Paint()
          ..color = const Color(0x4400FF00)
          ..strokeWidth = 0.03,
      );
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await add(
      FlameBlocListener<ShotBloc, ShotState>(
        onNewState: (state) {
          previousShots = state.shots[levelId] ?? [];
        },
        listenWhen: (previous, current) =>
            previous.shots[levelId] != current.shots[levelId],
      ),
    );
    previousShots = bloc.state.shots[levelId] ?? [];
  }
}
