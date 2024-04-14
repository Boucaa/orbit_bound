import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:space_balls/ui/theme/colors.dart';

import '../../../../business/user_bloc.dart';

class LocaleFlagButton extends StatelessWidget {
  final String asset;
  final String locale;

  const LocaleFlagButton({
    super.key,
    required this.asset,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            final userBloc = context.read<UserBloc>();
            userBloc.add(
              UpdateUser(
                userBloc.state.user!.copyWith(locale: locale),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: state.user?.locale == locale ? Colors.white : lightBlue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: SvgPicture.asset(
                  asset,
                  width: 45,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
