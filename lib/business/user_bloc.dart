import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_balls/data/user_repository.dart';
import 'package:space_balls/model/user.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(const UserState(null)) {
    on<LoadUser>((event, emit) async {
      final user = await userRepository.loadUser();
      emit(state.copyWith(user: user));
    });

    on<UpdateUser>((event, emit) async {
      await userRepository.saveUser(event.user);
      emit(state.copyWith(user: event.user));
    });
  }
}
