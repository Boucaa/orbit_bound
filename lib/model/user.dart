import 'package:equatable/equatable.dart';

class User extends Equatable {
  final Set<String> completedLevelIds;
  final String? locale;

  const User({
    this.completedLevelIds = const {},
    this.locale,
  });

  User copyWith({
    Set<String>? completedLevelIds,
    String? locale,
  }) {
    return User(
      completedLevelIds: completedLevelIds ?? this.completedLevelIds,
      locale: locale ?? this.locale,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'completedLevelIds': completedLevelIds.toList(),
      'locale': locale ?? 'en',
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      completedLevelIds: ((map['completedLevelIds'] ?? []) as List)
          .map((e) => e as String)
          .toSet(),
      locale: map['locale'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        completedLevelIds,
        locale,
      ];
}
