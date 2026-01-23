import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'router_state.dart';

class RouterCubit extends Cubit<RouterState> {
  /// The flutter secure storage
  final storage = const FlutterSecureStorage();

  RouterCubit() : super(const RouterInitial()) {
    init();
  }

  Future<void> init() async {
    final lastKnownRoute = await storage.read(key: "lastKnownRoute");
    if (lastKnownRoute != null) {
      emit(RouterInitial(lastKnownRoute: lastKnownRoute));
    }
  }

  /// Store the current route
  void storeCurrentRoute(String routePath) async {
    await storage.write(key: "lastKnownRoute", value: routePath);
    emit(RouterInitial(lastKnownRoute: routePath));
  }

  /// Return the last known route
  String? get lastKnownRoute => (state as RouterInitial).lastKnownRoute;
}
