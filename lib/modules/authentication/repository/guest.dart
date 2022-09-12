

import 'package:either_dart/either.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/ConsentDetail.dart';
import 'package:flutter_beconsent_sdk/network/impl/network_error.dart';
abstract class AuthenticationRepository {
  Future<Either<NetworkError, ConsentDetail>> getConsentDetail();

}
