import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:police_flutter_template/screens/app.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Register logging
  final talker = Talker(
    settings: TalkerSettings(
      // colors: {TalkerLogType.blocEvent.key: AnsiPen()..red(), TalkerLogType.blocTransition.key: AnsiPen()..yellow()},
    ),
  );
  Bloc.observer = TalkerBlocObserver(talker: talker);

  // Setup dependency injection
  final getIt = GetIt.instance;
  getIt.registerSingleton<Talker>(talker);

  runApp(const App());
}