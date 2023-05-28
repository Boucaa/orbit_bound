import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_balls/business/user_bloc.dart';
import 'package:space_balls/data/level_repository.dart';
import 'package:space_balls/data/user_repository.dart';

class BaseProvider extends StatelessWidget {
  final Widget child;

  const BaseProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => LevelRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => UserBloc(
          userRepository: context.read<UserRepository>(),
        )..add(
            LoadUser(),
          ),
        child: child,
      ),
    );
  }
}
