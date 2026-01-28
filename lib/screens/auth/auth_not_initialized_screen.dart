import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:police_flutter_template/extensions/text_extensions.dart';
import 'package:police_flutter_template/extensions/widget_extensions.dart';
import 'package:police_flutter_template/screens/auth/widgets/loading_service.dart';
import 'package:police_flutter_template/settings/app_constants.dart';
import 'package:police_flutter_template/settings/auth_init_tasks.dart';
import 'package:police_flutter_template/theme/cubit/theme_cubit.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../routes/cubit/router_cubit.dart';
import '../../routes/route_names.dart';

class AuthNotInitializedScreen extends StatefulWidget {
  const AuthNotInitializedScreen({super.key, this.from});

  /// Optional route we attempted to navigate to before initialization.
  ///
  /// Typically used for "resume navigation after init" scenarios.
  final String? from;

  @override
  State<AuthNotInitializedScreen> createState() =>
      _AuthNotInitializedScreenState();
}

class _AuthNotInitializedScreenState extends State<AuthNotInitializedScreen> {
  /// Subscription to router state updates to keep track of the last known route.
  late final StreamSubscription<RouterState> _routerStream;

  /// App version shown in the footer (loaded asynchronously).
  String _version = '0.0.0';

  /// Index of the task currently being executed.
  int _currentTaskIndex = 0;

  /// Ordered list of initialization tasks shown as a stepper/loading list.
  late List<InitTask> _initTasks;

  /// Last route remembered by the router layer (used to resume navigation).
  String? lastKnownRoute;

  /// Whether at least one task failed.
  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    // Build the initialization task list (order matters for the UI).
    _initTasks = AuthInitTasks(context: context).tasks;

    // Load app metadata such as version/build number for display.
    _loadAppInfo();

    // Track router state so we can resume the last known route after init.
    final routerCubit = context.read<RouterCubit>();
    lastKnownRoute = routerCubit.lastKnownRoute;
    _routerStream = routerCubit.stream.listen((route) {
      lastKnownRoute = (route as RouterInitial).lastKnownRoute;
    });
  }

  /// Loads app information (e.g. version) from the underlying platform.
  Future<void> _loadAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (!mounted) return;
    setState(() {
      _version = packageInfo.version;
    });
  }

  @override
  void dispose() {
    _routerStream.cancel();
    super.dispose();
  }

  /// Navigates away from the initialization screen once we are authorized.
  ///
  /// Prefers:
  /// 1) [lastKnownRoute] from the router state, else
  /// 2) [widget.from] (if provided and not pointing back to initialize), else
  /// 3) fallback to home.
  void _loadPage(AuthState state) {
    final fromUrl =
        lastKnownRoute ??
        (widget.from == null || widget.from == RouteNames.initializeUrl
            ? null
            : widget.from);
    if (state is Authorized) {
      context.go(
        fromUrl == RouteNames.initializeUrl
            ? RouteNames.homeUrl
            : fromUrl ?? RouteNames.homeUrl,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;

    // Progress in percent (0..100). Uses task index, not per-task internal progress.
    final progress = _initTasks.isEmpty
        ? 0.0
        : (_currentTaskIndex / _initTasks.length) * 100;

    return Scaffold(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [Colors.gray[950], Colors.blue[950], Colors.gray[900]]
                : [Colors.blue[900], Colors.blue[800], Colors.blue[950]],
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // App logo.
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.gray[800] : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/logo/polizeistern.svg',
                      height: 100,
                      semanticsLabel: 'Berliner Polizei Logo',
                    ),
                  ).animatePulse(
                    // Pulse until we reach 100%.
                    enabled: progress < 100,
                    duration: const Duration(seconds: 1),
                  ),
                  Gap(24),

                  // Headline / project branding.
                  Text(
                    AppConstants.organization,
                  ).h3.setColors(lightColor: Colors.white),
                  Gap(10),
                  Text(AppConstants.projectTitle).h4.setColors(
                    lightColor: Colors.blue[200],
                    darkColor: Colors.blue[300],
                  ),
                  Gap(48),

                  // Initialization card: progress + task list.
                  Card(
                    filled: true,
                    fillColor: isDarkMode ? Colors.gray[800] : Colors.white,
                    borderWidth: 0,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Initialisierung').setColors(
                              lightColor: Colors.gray[600],
                              darkColor: Colors.gray[400],
                            ),
                            Text(
                              '${progress.toStringAsFixed(0)}%',
                            ).semiBold.setColors(
                              lightColor: Colors.blue[700],
                              darkColor: Colors.blue[400],
                            ),
                          ],
                        ),
                        Gap(10),
                        SizedBox(
                          width: double.infinity,
                          child: Progress(
                            progress: progress,
                            min: 0,
                            max: 100,
                            color: isDarkMode
                                ? Colors.blue[500]
                                : Colors.blue[700],
                          ),
                        ),
                        Gap(24),
                        Column(
                          children: _initTasks.asMap().entries.map((entry) {
                            final index = entry.key;
                            final task = entry.value;

                            return LoadingService(
                              title: task.title,

                              // Starts when this index is the next pending task.
                              startLoading: _currentTaskIndex == index,

                              // The task's async action. Returns success/failure.
                              onLoading: task.action,

                              // Called by LoadingService when the task completed.
                              onLoaded: (success) {
                                if (!mounted) return;
                                setState(() {
                                  _currentTaskIndex++;
                                  if (!success) {
                                    _hasError = true;
                                  }
                                });

                                // Once all tasks have finished successfully, proceed.
                                if (_initTasks.length == _currentTaskIndex &&
                                    !_hasError) {
                                  _loadPage(context.read<AuthBloc>().state);
                                }
                              },
                            );
                          }).toList(),
                        ).gap(10),
                        Gap(24),
                        if (_initTasks.length == _currentTaskIndex && _hasError)
                          SizedBox(
                            width: double.infinity,
                            child: Card(
                              filled: true,
                              fillColor: isDarkMode
                                  ? Colors.red[900].withAlpha(51)
                                  : Colors.red[50],
                              borderColor: isDarkMode
                                  ? Colors.red[800]
                                  : Colors.red[200],
                              borderWidth: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        LucideIcons.x,
                                        color: isDarkMode
                                            ? Colors.red[300]
                                            : Colors.red[800],
                                      ),
                                      Text(
                                        'Initialisierung fehlgeschlagen',
                                      ).small.setColors(
                                        lightColor: Colors.red[800],
                                        darkColor: Colors.red[300],
                                      ),
                                    ],
                                  ).gap(5),
                                  IconButton(
                                    size: ButtonSize.small,
                                    icon: Icon(LucideIcons.refreshCcw),
                                    variance: ButtonVariance.destructive,

                                    // Resets the task runner back to step 0.
                                    // Note: does not recreate the task list.
                                    onPressed: () {
                                      if (!mounted) return;
                                      setState(() {
                                        _currentTaskIndex = 0;
                                      });
                                    },
                                  ),
                                ],
                              ).gap(5),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Footer.
                  Gap(24),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Sichere Verbindung • Verschlüsselte Übertragung',
                      ).xSmall.setColors(
                        lightColor: Colors.blue[200],
                        darkColor: Colors.blue[400],
                      ),
                    ],
                  ),
                  Gap(4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_version).xSmall
                          .setColors(
                            lightColor: Colors.blue[300],
                            darkColor: Colors.blue[500],
                          )
                          // Shows a skeleton until we loaded the real version.
                          .asSkeleton(enabled: _version == "0.0.0"),
                      Text(
                        ' • © ${DateTime.now().year} Berliner Polizei',
                      ).xSmall.setColors(
                        lightColor: Colors.blue[300],
                        darkColor: Colors.blue[500],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
