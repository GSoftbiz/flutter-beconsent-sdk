import 'package:flutter_beconsent_sdk/core/user_session/impl/user_session.dart';
import 'package:flutter_beconsent_sdk/core/user_session/user_session.dart';
import 'package:flutter_beconsent_sdk/di/injector.dart';
import 'package:flutter_beconsent_sdk/network/network_authentication.dart';
import 'package:either_dart/either.dart';

class NetworkAuthenticationImpl extends NetworkAuthentication {
  NetworkAuthenticationImpl();

  @override
  String? get accessToken => Injector.instance.userSession.accessToken;

  @override
  // TODO: implement userId
  Future<String?> get userId => throw UnimplementedError();

  @override
  Future<bool> doRefreshToken() async {
    /*
    bool success = false;
    final inj = Injector.instance;
    await inj.authenticationRepository
        .refreshToken(RefreshTokenForm(inj.userSession.refreshToken))
        .fold(
            (left) => {},
            (right) => {
                  inj.userSession
                      .saveSession(right.accessToken, right.refreshToken),
                  success = true
                });

     */
    return true;
  }
}
