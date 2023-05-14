part of 'user_bloc.dart';

class UserState extends Equatable {
  final User? user;

  const UserState(this.user);

  UserState copyWith({User? user}) {
    return UserState(
      user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [user];
}
