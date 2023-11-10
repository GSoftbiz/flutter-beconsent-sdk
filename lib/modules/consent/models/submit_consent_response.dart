import 'package:flutter_beconsent_sdk/modules/consent/models/get_consent_detail_response.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/version.dart';

class SubmitConsentResponse {
  SubmitConsentResponse({
    required this.purposes,
    required this.action,
    required this.consentVersion,
    required this.collectionChannel,
  });
  late final List<Purposes> purposes;
  late final String action;
  late final Version consentVersion;
  late final String collectionChannel;


  bool isNone() {
    return action.contains("NONE");
  }

  bool isAll() {
    return action.contains("ALL");
  }

  SubmitConsentResponse.fromJson(Map<String, dynamic> json) {
    //purposes = List.from(json['purposes']).map((e) => Purposes.fromJson(e)).toList();
    action = json['action'];
    collectionChannel = json['collectionChannel'];
    consentVersion = Version.fromJson(json);
  }
}
