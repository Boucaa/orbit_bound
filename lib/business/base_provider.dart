import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_balls/business/user_bloc.dart';
import 'package:space_balls/data/level_repository.dart';
import 'package:space_balls/data/shot/shot_bloc.dart';
import 'package:space_balls/data/user_repository.dart';

class BaseProvider extends StatelessWidget {
  final Widget child;

  const BaseProvider({
    super.key,
    required this.child,
  });

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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserBloc(
              userRepository: context.read<UserRepository>(),
            )..add(
                LoadUser(),
              ),
          ),
          BlocProvider(
            create: (context) => ShotBloc(),
          ),
        ],
        child: child,
      ),
    );
  }
}
