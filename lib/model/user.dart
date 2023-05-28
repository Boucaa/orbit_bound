import 'package:equatable/equatable.dart';

class User extends Equatable {
  final Set<String> completedLevelIds;

  const User({
    this.completedLevelIds = const {},
  });

  User copyWith({
    Set<String>? completedLevelIds,
  }) {
    return User(
      completedLevelIds: completedLevelIds ?? this.completedLevelIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'completedLevelIds': completedLevelIds.toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      completedLevelIds: ((map['completedLevelIds'] ?? []) as List)
          .map((e) => e as String)
          .toSet(),
    );
  }

  @override
  List<Object?> get props => [
        completedLevelIds,
      ];
}
