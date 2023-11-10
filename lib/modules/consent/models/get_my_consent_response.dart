import 'package:flutter_beconsent_sdk/modules/consent/models/consent_version.dart';
import 'package:flutter_beconsent_sdk/modules/consent/models/get_consent_detail_response.dart';

import '../../dsrm/models/create_dsrm_body.dart';

class GetMyConsentResponse {
  GetMyConsentResponse({
    required this.purposes,
    required this.action,
    required this.consentVersion,
    required this.hasGuardian,
    required this.guardianInformation,
  });

  late final List<Purposes>? purposes;
  late final String action;
  late final ConsentVersion consentVersion;
  late final GuardianInformation guardianInformation;
  late final bool hasGuardian;

  bool isNone() {
    return action.contains("NONE");
  }

  bool isAll() {
    return action.contains("ALL");
  }

  GetMyConsentResponse.fromJson(Map<String, dynamic> json) {
    purposes =json['purposes']!=null?List.from(json['purposes']).map((e)=>Purposes.fromJson(e)).toList():null;
    action = json['action'];
    hasGuardian = json['hasGuardian'];
    guardianInformation = GuardianInformation.fromJson(json['guardianInformation']);
    consentVersion = ConsentVersion.fromJson(json['consentVersion']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['action'] = action;
    _data['consentVersion'] = consentVersion;
    _data['purposes'] = purposes?.map((e) => e.toJson()).toList();
    return _data;
  }
}
