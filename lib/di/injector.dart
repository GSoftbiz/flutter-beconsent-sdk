import 'package:flutter_beconsent_sdk/core/secure_storage/secure_storage.dart';
import 'package:flutter_beconsent_sdk/core/user_session/impl/user_session.dart';
import 'package:flutter_beconsent_sdk/core/user_session/user_session.dart';
import 'package:flutter_beconsent_sdk/modules/authentication/repository/guest.dart';
import 'package:flutter_beconsent_sdk/modules/authentication/repository/impl/guest.dart';
import 'package:flutter_beconsent_sdk/network/network.dart';

class Injector {
  static final Injector _singleton = Injector._internal();
  late AuthenticationRepository _authenticationRepository;
  late UserSession _userSession;

  static Injector get instance => _singleton;

  Injector._internal();

  void setup({
    required Network apiClient,
    required SecureStorage secureStorage,
  }) {

    _authenticationRepository = AuthenticationRepositoryImpl(apiClient);
    _userSession = UserSessionImpl(secureStorage);
    _userSession.loadSession();
  }

  UserSession get userSession => _userSession;



  AuthenticationRepository get authenticationRepository =>
      _authenticationRepository;
}
