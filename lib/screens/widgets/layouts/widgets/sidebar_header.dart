import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:police_flutter_template/extensions/text_extensions.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../bloc/auth/auth_bloc.dart';
import '../../../../settings/app_constants.dart';
import '../../../../theme/cubit/theme_cubit.dart';

class SidebarHeader extends StatelessWidget {
  const SidebarHeader({super.key, required this.sidebarContext});

  final BuildContext sidebarContext;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = (state as Authorized).user;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: isDarkMode
                  ? [Colors.blue[800], Colors.blue[700]]
                  : [Colors.blue[900], Colors.blue[800]],
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          'assets/logo/polizeistern.svg',
                          height: 40,
                          semanticsLabel: 'Berliner Polizei Logo',
                        ),
                      ),
                      Gap(15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppConstants.projectTitle,
                          ).semiBold.large.setColors(lightColor: Colors.white),
                          Text(
                            'Menü',
                          ).xSmall.setColors(lightColor: Colors.blue[200]),
                        ],
                      ).gap(2),
                    ],
                  ),
                  Button(
                    style: ButtonStyle.ghostIcon().withBackgroundColor(
                      hoverColor: Colors.white.withAlpha(50),
                    ),
                    onPressed: () => closeSheet(sidebarContext),
                    child: const Icon(LucideIcons.x, color: Colors.white),
                  ),
                ],
              ),
              Gap(16),
              // User Profile in Mobile
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.firstName} ${user.lastName}',
                    ).semiBold.small.setColors(lightColor: Colors.white),
                    Text(
                      'Pers. Nr.: ${user.id}',
                    ).xSmall.setColors(lightColor: Colors.blue[200]),
                  ],
                ),
              ),
            ],
          ).withPadding(all: 24),
        );
      },
    );
  }
}
