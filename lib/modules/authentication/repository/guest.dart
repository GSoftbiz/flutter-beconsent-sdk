import 'package:either_dart/either.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/get_my_consent_body.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/get_my_consent_response.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/get_consent_detail_response.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/submit_consent_body.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/submit_consent_response.dart';
import 'package:flutter_beconsent_sdk/modules/dsrm/models/create_dsrm_body.dart';
import 'package:flutter_beconsent_sdk/modules/dsrm/models/create_dsrm_response.dart';
import 'package:flutter_beconsent_sdk/modules/dsrm/models/drsm_form_response.dart';
import 'package:flutter_beconsent_sdk/network/impl/network_error.dart';

abstract class AuthenticationRepository {
  Future<Either<NetworkError, GetConsentDetailResponse>> getConsentDetail();
  Future<Either<NetworkError, GetMyConsentResponse>> getMyConsent(GetMyConsentBody body);
  Future<Either<NetworkError, SubmitConsentResponse>> submitConsent(SubmitConsentBody body);
  Future<Either<NetworkError, DSRMFormResponse>> getDSRMForm();
  Future<Either<NetworkError, CreateDSRMResponse>> createDSRM(CreateDSRMBody body);
}
