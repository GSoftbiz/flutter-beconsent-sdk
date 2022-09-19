import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/get_consent_detail_response.dart';
import 'package:flutter_beconsent_sdk/modules/dsrm/models/create_dsrm_body.dart';
import 'package:flutter_beconsent_sdk/theme/app_theme.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../core/secure_storage/impl/secure_storage.dart';
import '../../di/injector.dart';
import '../../network/impl/network_authentication_impl.dart';
import '../../network/impl/network_impl.dart';

class BeConsent {
  static String baseUrl = "https://rst-consent.beconsent.tech/api/v1/";
  static String? workSpaceID = "";
  static String? consentAppID = "";
  static String? dsrmFormID = "";
  static String? uuid = "";
  static String? consentUserName = "";
  static GetConsentDetailResponse? consentDetail;

  static String? appNameTh = "Organization";
  static String? appNameEn = "Organization";
  static String? logo = "Organization";
  static bool logoVisible = true;
  static String? idFirstName;
  static String? idLastName;
  static String? idEmail;

  static setIdentity({String? firstName, lastName, email}) {
    BeConsent.idFirstName = firstName;
    BeConsent.idLastName = lastName;
    BeConsent.idEmail = email;
  }

  static init(
      {String? workSpaceID,
      String? consentAppID,
      Color? color,
      String? dsrmFormID,
      String? appNameTH,
      String? appNameEN,
      String? logo,
      bool? logoVisible}) async {
    BeConsent.workSpaceID = workSpaceID;
    BeConsent.consentAppID = consentAppID;
    BeConsent.dsrmFormID = dsrmFormID;
    BeConsent.appNameTh = appNameTH;
    BeConsent.appNameEn = appNameEN;
    BeConsent.logo = logo;
    BeConsent.logoVisible = logoVisible ?? true;
    if (color != null) {
      AppTheme.setPrimaryColor(color);
    }
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
