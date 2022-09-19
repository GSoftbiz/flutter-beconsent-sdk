import 'package:flutter_beconsent_sdk/core/repository/repository.dart';
import 'package:flutter_beconsent_sdk/modules/authentication/repository/guest.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/get_my_consent_body.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/get_my_consent_response.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/get_consent_detail_response.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/submit_consent_body.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/submit_consent_response.dart';
import 'package:flutter_beconsent_sdk/modules/dsrm/models/create_dsrm_body.dart';
import 'package:flutter_beconsent_sdk/modules/dsrm/models/create_dsrm_response.dart';
import 'package:flutter_beconsent_sdk/modules/dsrm/models/drsm_form_response.dart';
import 'package:flutter_beconsent_sdk/network/impl/network_error.dart';
import 'package:flutter_beconsent_sdk/network/network.dart';
import 'package:either_dart/either.dart';

import '../../../consent/beconsent.dart';


class AuthenticationRepositoryImpl extends Repository
    implements AuthenticationRepository {
  AuthenticationRepositoryImpl(Network apiClient) : super(apiClient);

  @override
  Future<Either<NetworkError, GetConsentDetailResponse>>
      getConsentDetail() async {
    try {
      final response = await apiClient.get(
          '${BeConsent.workSpaceID}/consent-versions/application/${BeConsent.consentAppID}');
      return Right(GetConsentDetailResponse.fromJson(response.data));
    } on NetworkError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NetworkError.wrap(e));
    }
  }

  @override
  Future<Either<NetworkError, SubmitConsentResponse>> submitConsent(
      SubmitConsentBody body) async {
    try {
      final response = await apiClient
          .post('${BeConsent.workSpaceID}/user-consents', body: body.toJson());
      return Right(SubmitConsentResponse.fromJson(response.data));
    } on NetworkError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NetworkError.wrap(e));
    }
  }

  @override
  Future<Either<NetworkError, GetMyConsentResponse>> getMyConsent(
      GetMyConsentBody body) async {
    try {
      final response = await apiClient.post(
          '${BeConsent.workSpaceID}/user-consents/consent/${BeConsent.consentDetail?.consentUUID}/version/${BeConsent.consentDetail?.version}/get-user-consent',
          body: body.toJson());
      return Right(GetMyConsentResponse.fromJson(response.data));
    } on NetworkError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NetworkError.wrap(e));
    }
  }

  @override
  Future<Either<NetworkError, DSRMFormResponse>> getDSRMForm() async {
    try {
      final response = await apiClient.get(
          '${BeConsent.workSpaceID}/dsrm-request-form-versions/${BeConsent.dsrmFormID}/latest');
      return Right(DSRMFormResponse.fromJson(response.data));
    } on NetworkError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NetworkError.wrap(e));
    }
  }

  @override
  Future<Either<NetworkError, CreateDSRMResponse>> createDSRM(CreateDSRMBody body) async {
    try {
      final response = await apiClient.post(
          '${BeConsent.workSpaceID}/dsrm-request',body:body.toJson());
      return Right(CreateDSRMResponse.fromJson(response.data));
    } on NetworkError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NetworkError.wrap(e));
    }
  }
}
