part of 'game_bloc.dart';

class GameState extends Equatable {
  final List<GameObject> objects;
  final bool isRunning;
  final Offset? previewStart;
  final Offset? previewOffset;

  const GameState({
    this.objects = const [],
    this.isRunning = false,
    this.previewStart,
    this.previewOffset,
  });

  GameState copyWith({
    List<GameObject>? objects,
    bool? isRunning,
    Offset? Function()? previewStart,
    Offset? Function()? previewOffset,
  }) {
    return GameState(
      objects: objects ?? this.objects,
      isRunning: isRunning ?? this.isRunning,
      previewStart:
          previewStart != null ? previewStart.call() : this.previewStart,
      previewOffset:
          previewOffset != null ? previewOffset.call() : this.previewOffset,
    );
  }

  @override
  List<Object?> get props => [
        objects,
        isRunning,
        previewStart,
        previewOffset,
      ];
}
