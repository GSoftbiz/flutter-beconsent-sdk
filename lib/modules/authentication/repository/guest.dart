import 'package:either_dart/either.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/GetMyConsentBody.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/GetMyConsentResponse.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/GetConsentDetailResponse.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/SubmitConsentBody.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/SubmitConsentResponse.dart';
import 'package:flutter_beconsent_sdk/network/impl/network_error.dart';

abstract class AuthenticationRepository {
  Future<Either<NetworkError, GetConsentDetailResponse>> getConsentDetail();
  Future<Either<NetworkError, GetMyConsentResponse>> getMyConsent(GetMyConsentBody body);
  Future<Either<NetworkError, SubmitConsentResponse>> submitConsent(SubmitConsentBody body);
}
