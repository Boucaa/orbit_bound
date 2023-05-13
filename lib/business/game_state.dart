part of 'game_bloc.dart';

class GameState extends Equatable {
  final List<GameObject> objects;
  final bool isRunning;
  final Offset? previewStart;
  final Offset? previewOffset;
  final DateTime lastTick;
  final GameLevel level;

  const GameState({
    this.objects = const [],
    this.isRunning = false,
    this.previewStart,
    this.previewOffset,
    required this.lastTick,
    required this.level,
  });

  GameState copyWith({
    List<GameObject>? objects,
    bool? isRunning,
    Offset? Function()? previewStart,
    Offset? Function()? previewOffset,
    DateTime? lastTick,
    GameLevel? level,
  }) {
    return GameState(
      objects: objects ?? this.objects,
      isRunning: isRunning ?? this.isRunning,
      previewStart:
          previewStart != null ? previewStart.call() : this.previewStart,
      previewOffset:
          previewOffset != null ? previewOffset.call() : this.previewOffset,
      lastTick: lastTick ?? this.lastTick,
      level: level ?? this.level,
    );
  }

  @override
  List<Object?> get props => [
        objects,
        isRunning,
        previewStart,
        previewOffset,
        lastTick,
      ];
}
