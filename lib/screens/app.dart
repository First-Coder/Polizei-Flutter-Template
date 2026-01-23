import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:police_flutter_template/settings/app_constants.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../bloc/auth/auth_bloc.dart';
import '../routes/cubit/router_cubit.dart';
import '../routes/route_config.dart';
import '../theme/cubit/theme_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final talker = GetIt.instance.get<Talker>();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit(), lazy: false),
        BlocProvider<RouterCubit>(create: (_) => RouterCubit(), lazy: false),
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) => ShadcnApp.router(
          title: '${AppConstants.projectTitle} | ${AppConstants.organization}',
          theme: state.themeData,
          debugShowCheckedModeBanner: false,
          routerConfig: RouteConfig.returnRouter(talker),
        ),
      ),
    );
  }
}
