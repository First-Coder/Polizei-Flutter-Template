import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police_flutter_template/extensions/widget_extensions.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../theme/cubit/theme_cubit.dart';

/// The lifecycle state of a single loading step shown in the initialization UI.
///
/// - [waiting]: the step has not started yet
/// - [working]: the step is currently running
/// - [done]: the step completed successfully
/// - [failed]: the step completed with failure
enum LoadingState { waiting, working, done, failed }

/// A reusable widget that executes an async loading callback and displays its status.
///
/// Intended usage:
/// - Used as a single row/line item in an initialization checklist / stepper.
/// - When [startLoading] becomes true, it runs [onLoading] once and transitions the UI:
///   [LoadingState.waiting] → [LoadingState.working] → ([done] | [failed]).
///
/// UI behavior:
/// - Shows a colored status indicator (neutral/blue/green/red depending on state).
/// - Pulses the indicator while [LoadingState.working] using `.animatePulse(...)`.
/// - Uses [ThemeCubit] to adjust colors for dark/light mode.
///
/// Callbacks:
/// - [onLoading] must return `true` for success, `false` for failure.
/// - [onLoaded] is invoked after completion (success/failure) so the parent can advance.
///
/// Notes:
/// - This widget does not implement retries by itself; the parent can rebuild/reset it.
/// - [onLoaded] is called even if the widget later becomes unmounted; avoid heavy UI work
///   in that callback without checking `mounted` in the caller if needed.
class LoadingService extends StatefulWidget {
  const LoadingService({
    super.key,
    required this.onLoading,
    required this.startLoading,
    required this.title,
    this.onLoaded,
  });

  /// Title displayed next to the status indicator.
  final String title;

  /// Async action representing the loading step.
  ///
  /// Return `true` if the step succeeded, otherwise `false`.
  final Future<bool> Function() onLoading;

  /// Optional callback invoked after [onLoading] completes.
  ///
  /// Provides the boolean success result.
  final void Function(bool success)? onLoaded;

  /// Whether this step should start running.
  ///
  /// - If `true` at first build, the step starts in [initState].
  /// - If it changes from `false` to `true`, the step starts in [didUpdateWidget].
  final bool startLoading;

  @override
  State<LoadingService> createState() => _LoadingServiceState();
}

class _LoadingServiceState extends State<LoadingService> {
  /// Internal state for rendering.
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

    // Trigger loading when the parent flips startLoading from false to true.
    if (widget.startLoading && !oldWidget.startLoading) {
      _load();
    }
  }

  /// Runs the step's async action and updates UI state accordingly.
  Future<void> _load() async {
    setState(() {
      _state = LoadingState.working;
    });

    final success = await widget.onLoading();

    // Inform the parent (e.g. to advance to next step).
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
        // Status indicator: color + icon/dot changes by LoadingState.
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

        // Step label.
        Text(
          '${widget.title}...',
          style: Theme.of(context).typography.base.copyWith(
            fontSize: 14,
            color: _state == LoadingState.done || _state == LoadingState.working
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
    ).gap(10);
  }
}
