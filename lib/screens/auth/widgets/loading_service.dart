import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police_flutter_template/extensions/widget_extensions.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../theme/cubit/theme_cubit.dart';

enum LoadingState { waiting, working, done, failed }

class LoadingService extends StatefulWidget {
  const LoadingService({
    super.key,
    required this.onLoading,
    required this.startLoading,
    required this.title,
    this.onLoaded,
  });

  /// Title of the loading service
  final String title;

  /// Callback for loading
  final Future<bool> Function() onLoading;

  /// Callback for when loading is done
  final void Function(bool success)? onLoaded;

  /// Start loading
  final bool startLoading;

  @override
  State<LoadingService> createState() => _LoadingServiceState();
}

class _LoadingServiceState extends State<LoadingService> {
  LoadingState _state = LoadingState.waiting;

  @override
  void initState() {
    super.initState();
    if (widget.startLoading) {
      _load();
    }
  }

  @override
  void didUpdateWidget(LoadingService oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.startLoading && !oldWidget.startLoading) {
      _load();
    }
  }

  Future<void> _load() async {
    setState(() {
      _state = LoadingState.working;
    });
    final success = await widget.onLoading();
    widget.onLoaded?.call(success);
    if (!mounted) return;
    setState(() {
      _state = success ? LoadingState.done : LoadingState.failed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;
    return Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: _state == LoadingState.waiting
                    ? isDarkMode
                          ? Colors.gray[600]
                          : Colors.gray[300]
                    : _state == LoadingState.working
                    ? isDarkMode
                          ? Colors.blue[600]
                          : Colors.blue[500]
                    : _state == LoadingState.done
                    ? isDarkMode
                          ? Colors.green[600]
                          : Colors.green[500]
                    : isDarkMode
                    ? Colors.red[600]
                    : Colors.red[500],
                borderRadius: BorderRadius.circular(12),
              ),
              child: _state == LoadingState.done
                  ? Icon(LucideIcons.circleCheck, color: Colors.white, size: 14)
                  : _state == LoadingState.failed
                  ? Icon(LucideIcons.circleAlert, color: Colors.white, size: 14)
                  : Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _state == LoadingState.waiting
                            ? isDarkMode
                                  ? Colors.gray[500]
                                  : Colors.gray[400]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ).center(),
            ).animatePulse(
              enabled: _state == LoadingState.working,
              duration: const Duration(milliseconds: 600),
              lowerBound: 0.4,
            ),
            Text(
              '${widget.title}...',
              style: Theme.of(context).typography.base.copyWith(
                fontSize: 14,
                color:
                    _state == LoadingState.done ||
                        _state == LoadingState.working
                    ? isDarkMode
                          ? Colors.gray[100]
                          : Colors.gray[900]
                    : _state == LoadingState.failed
                    ? isDarkMode
                          ? Colors.red[500]
                          : Colors.red[600]
                    : isDarkMode
                    ? Colors.gray[400]
                    : Colors.gray[500],
              ),
            ),
          ],
        )
        .gap(10);
  }
}
