import 'dart:async';
import 'dart:isolate';

import 'package:flutter_beconsent_sdk/core/user_session/impl/user_session.dart';
import 'package:flutter_beconsent_sdk/core/user_session/user_session.dart';
import 'package:flutter_beconsent_sdk/network/impl/network_authentication_impl.dart';
import 'package:flutter_beconsent_sdk/network/network_authentication.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_beconsent_sdk/app.dart';
import 'package:flutter_beconsent_sdk/configs/app_configs.dart';
import 'package:flutter_beconsent_sdk/core/secure_storage/impl/secure_storage.dart';
import 'package:flutter_beconsent_sdk/di/injector.dart';
import 'package:flutter_beconsent_sdk/network/impl/network_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {}

Future<void> handleError(Object error, StackTrace? stack) async {
  //await FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
}

void run(Config config) async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    //await Firebase.initializeApp();
    //await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    final storage = SecureStorageImpl('beConsent');
    Injector.instance.setup(
      apiClient: NetworkImpl(
          Dio()
            ..options.baseUrl = config.baseURL
            ..options.connectTimeout = 60000
            ..options.receiveTimeout = 60000,
          authenticationDelegate: NetworkAuthenticationImpl()),
      secureStorage: storage,
    );
    /*
    FlutterError.onError = (FlutterErrorDetails details) async {
      await handleError(details.exception, details.stack);
    };

    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await handleError(errorAndStacktrace.first, errorAndStacktrace.last);
    }).sendPort);

     */

    runApp(
      EasyLocalization(
        path: config.localizationPath,
        supportedLocales: config.supportedLocales,
        fallbackLocale: config.fallbackLocale,
        child: const App(),
      ),
    );
  }, (Object error, StackTrace stack) async {
    //await handleError(error, stack);
  });
}
