import 'package:flutter_beconsent_sdk/core/repository/repository.dart';
import 'package:flutter_beconsent_sdk/modules/authentication/repository/guest.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/ConsentDetail.dart';
import 'package:flutter_beconsent_sdk/network/impl/network_error.dart';
import 'package:flutter_beconsent_sdk/network/network.dart';
import 'package:either_dart/either.dart';

import '../../../consent/beconsent.dart';

class AuthenticationRepositoryImpl extends Repository
    implements AuthenticationRepository {
  AuthenticationRepositoryImpl(Network apiClient) : super(apiClient);

  @override
  Future<Either<NetworkError, ConsentDetail>> getConsentDetail() async {
    try {
      final response = await apiClient.get(
          '${BeConsent.workSpaceID}/consent-versions/application/${BeConsent.consentAppID}');
      return Right(ConsentDetail.fromJson(response.data));
    } on NetworkError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NetworkError.wrap(e));
    }
  }
}
