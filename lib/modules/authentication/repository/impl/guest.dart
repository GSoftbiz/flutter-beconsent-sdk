import 'package:flutter_beconsent_sdk/core/repository/repository.dart';
import 'package:flutter_beconsent_sdk/modules/authentication/repository/guest.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/GetMyConsentBody.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/GetMyConsentResponse.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/GetConsentDetailResponse.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/SubmitConsentBody.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/SubmitConsentResponse.dart';
import 'package:flutter_beconsent_sdk/network/impl/network_error.dart';
import 'package:flutter_beconsent_sdk/network/network.dart';
import 'package:either_dart/either.dart';

import '../../../consent/beconsent.dart';

class AuthenticationRepositoryImpl extends Repository
    implements AuthenticationRepository {
  AuthenticationRepositoryImpl(Network apiClient) : super(apiClient);

  @override
  Future<Either<NetworkError, GetConsentDetailResponse>> getConsentDetail() async {
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
      final response = await apiClient.post(
          '${BeConsent.workSpaceID}/user-consents',
          body: body.toJson());
      return Right(SubmitConsentResponse.fromJson(response.data));
    } on NetworkError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NetworkError.wrap(e));
    }
  }

  @override
  Future<Either<NetworkError, GetMyConsentResponse>> getMyConsent(GetMyConsentBody body) async {
    try {
      final response = await apiClient.post(
          '${BeConsent.workSpaceID}/user-consents/consent/${BeConsent.consentDetail?.consentId}/version/${BeConsent.consentDetail?.version}/get-user-consent',
          body: body.toJson());
      return Right(GetMyConsentResponse.fromJson(response.data));
    } on NetworkError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NetworkError.wrap(e));
    }
  }
}
