import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'router_state.dart';

/// A small Cubit responsible for persisting and exposing the "last known route".
///
/// Primary use case:
/// - Improve developer and user experience by restoring navigation state after
///   hot reload / app restart (when combined with router redirect logic).
///
/// Storage:
/// - Persists the last known route path in [FlutterSecureStorage] under the key
///   `"lastKnownRoute"`.
///
/// State model:
/// - Emits [RouterInitial] with an optional [RouterInitial.lastKnownRoute].
///
/// Notes / design considerations:
/// - This cubit uses secure storage. For purely UX-related route restoration,
///   shared preferences might also be sufficient depending on your requirements.
/// - [init] is called from the constructor; state will update asynchronously.
///   Consumers should handle `null` until initialization completes.
/// - Current implementation stores only the path string, not query params or extra state.
class RouterCubit extends Cubit<RouterState> {
  /// Storage used to persist the last known route across launches.
  ///
  /// Kept as a concrete instance for simplicity.
  final storage = const FlutterSecureStorage();

  /// Creates the cubit and starts asynchronous initialization.
  RouterCubit() : super(const RouterInitial()) {
    init();
  }

  /// Loads the persisted last known route from secure storage and emits it.
  ///
  /// If no route is stored, the cubit remains in its initial state with `null`.
  Future<void> init() async {
    final lastKnownRoute = await storage.read(key: "lastKnownRoute");
    if (lastKnownRoute != null) {
      emit(RouterInitial(lastKnownRoute: lastKnownRoute));
    }
  }

  /// Persists the current route path and updates the state.
  ///
  /// Parameters:
  /// - [routePath]: Typically a router location/path (e.g. `/home`).
  ///
  /// Side effects:
  /// - Writes to secure storage.
  /// - Emits [RouterInitial] containing the new route.
  void storeCurrentRoute(String routePath) async {
    await storage.write(key: "lastKnownRoute", value: routePath);
    emit(RouterInitial(lastKnownRoute: routePath));
  }

  /// Returns the last known route from the current state.
  ///
  /// Convenience getter for routing code (e.g. redirect hooks).
  ///
  /// Note:
  /// - This assumes the cubit always uses [RouterInitial] as state, which is true
  ///   in the current implementation.
  String? get lastKnownRoute => (state as RouterInitial).lastKnownRoute;
}
