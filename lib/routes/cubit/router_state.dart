part of 'router_cubit.dart';

/// Base state for [RouterCubit].
///
/// This is intentionally minimal; at the moment, the router state only needs to
/// carry a persisted "last known route" string.
///
/// Uses [Equatable] to make state comparisons predictable.
@immutable
sealed class RouterState extends Equatable {
  /// Creates a router state.
  const RouterState();

  @override
  List<Object?> get props => [];
}

/// Initial (and currently only) state emitted by [RouterCubit].
///
/// Holds:
/// - [lastKnownRoute]: the last stored route path, or `null` if none is stored yet.
final class RouterInitial extends RouterState {
  /// The last known route path persisted by the app (e.g. `/home`).
  final String? lastKnownRoute;

  /// Creates the initial router state.
  const RouterInitial({this.lastKnownRoute});

  @override
  List<Object?> get props => [lastKnownRoute];
}
