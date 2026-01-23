import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:police_flutter_template/bloc/auth/models/user_model.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// The flutter secure storage
  final storage = const FlutterSecureStorage();

  AuthBloc() : super(AuthNotInitialized()) {
    on<Login>(_onLogin);
    on<LoadAuthentication>(_onLoadAuthentication);
    on<ReloadAuthentication>(_onReloadAuthentication);
  }

  /// Reload the authentication
  void _onReloadAuthentication(
    ReloadAuthentication event,
    Emitter<AuthState> emit,
  ) async {
    // if ((state as Authorized).user) {
    //   if (kDebugMode) {
    //     print(
    //       "de.berlin.polizei.auth_bloc: Token is expired. Skipping authentication",
    //     );
    //   }
    //   emit(NotAuthorized(error: null));
    //   return;
    // }

    // final response = await _appwriteRepository.account
    //     .createEmailPasswordSession(email: username, password: password);
    //
    // final metaData = await _appwriteRepository.account.get();
    // _checkTheme(metaData);
    // emit(Authorized(session: response, user: metaData));
  }

  /// Load the authentication
  void _onLoadAuthentication(
    LoadAuthentication event,
    Emitter<AuthState> emit,
  ) async {
    // try {
    //   final session = await _appwriteRepository.account.getSession(
    //     sessionId: 'current',
    //   );
    //
    //   if (state is AuthNotInitialized) {
    //     final metaData = await _appwriteRepository.account.get();
    //     // _appwriteRepository.renewRealtimeSubscription();
    //     emit(Authorized(user: metaData, session: session));
    //   }
    // } on AppwriteException catch (e, stack) {
    //   if (e.code == 401) {
    //     _talker.warning('Session ist nicht mehr gültig oder abgelaufen.');
    //   } else {
    //     _talker.error(
    //       'Fehler beim Abrufen der Session: ${e.message} (Code: ${e.code})',
    //       e,
    //       stack,
    //     );
    //   }
    //   add(ReloadAuthentication());
    // }
  }

  /// Login the user
  void _onLogin(Login event, Emitter<AuthState> emit) async {
    // TODO: Implement login
    try {
      emit(
        Authorized(
          user: UserModel.fromJson({
            "id": "00000001",
            "firstName": "Max",
            "lastName": "Mustermann",
            "email": "max@mustermann.de",
          }),
        ),
      );
    } catch (e) {
      emit(NotAuthorized(error: e.toString()));
    }
  }
}
