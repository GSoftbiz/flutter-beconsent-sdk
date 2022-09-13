

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../core/secure_storage/impl/secure_storage.dart';
import '../../di/injector.dart';
import '../../network/impl/network_authentication_impl.dart';
import '../../network/impl/network_impl.dart';

//https://rst-consent.beconsent.tech/api/v1/bac482dc-3a6d-4a4e-ad9e-ce2332aa6aa7/consent-versions/application/07120b6b-8c61-4230-8fbe-aa11146785dc
//https://rst-consent.beconsent.tech/api/v1/bac482dc-3a6d-4a4e-ad9e-ce2332aa6aa7/user-consents/consent/1/version/2/get-user-consent
//https://rst-consent.beconsent.tech/api/v1/bac482dc-3a6d-4a4e-ad9e-ce2332aa6aa7/user-consents
class BeConsent {
  static String baseUrl = "https://rst-consent.beconsent.tech/api/v1/";
  static String? workSpaceID = "";
  static String? consentAppID = "";
  static String? DSRMFormID = "";

  static init({String? workSpaceID, String? consentAppID, String? DSRMFormID}) async {
    BeConsent.workSpaceID = workSpaceID;
    BeConsent.consentAppID = consentAppID;
    BeConsent.DSRMFormID = DSRMFormID;
    await EasyLocalization.ensureInitialized();
    WidgetsFlutterBinding.ensureInitialized();
    final storage = SecureStorageImpl('beconsent');
    Injector.instance.setup(
      apiClient: NetworkImpl(
          Dio()
            ..options.baseUrl = baseUrl
            ..options.connectTimeout = 60000
            ..options.receiveTimeout = 60000,
          authenticationDelegate: NetworkAuthenticationImpl()),
      secureStorage: storage,
    );
  }
}
