import 'package:equatable/equatable.dart';

class User extends Equatable {
  final Set<int> levelsCompleted;

  const User({
    this.levelsCompleted = const {},
  });

  User copyWith({
    Set<int>? levelsCompleted,
  }) {
    return User(
      levelsCompleted: levelsCompleted ?? this.levelsCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'levelsCompleted': levelsCompleted.toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      levelsCompleted:
          (map['levelsCompleted'] as List).map((e) => e as int).toSet(),
    );
  }

  @override
  List<Object?> get props => [
        levelsCompleted,
      ];
}
