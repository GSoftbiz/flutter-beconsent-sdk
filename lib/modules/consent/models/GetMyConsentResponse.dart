import 'package:flutter_beconsent_sdk/modules/consent/models/GetConsentDetailResponse.dart';

class GetMyConsentResponse {
  GetMyConsentResponse({
    required this.purposes,
    required this.action,
    required this.consentVersion,
  });

  late final List<Purposes> purposes;
  late final String action;
  late final String consentVersion;

  bool isNone() {
    return action.contains("NONE");
  }

  bool isAll() {
    return action.contains("ALL");
  }

  GetMyConsentResponse.fromJson(Map<String, dynamic> json) {
    purposes = List.from(json['purposes']).map((e) => Purposes.fromJson(e)).toList();
    action = json['action'];
    consentVersion = json['consentVersion'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['action'] = action;
    _data['consentVersion'] = consentVersion;
    _data['purposes'] = purposes.map((e) => e.toJson()).toList();
    return _data;
  }
}
