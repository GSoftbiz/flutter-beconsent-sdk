class SubmitConsentBody {
  SubmitConsentBody({
      String? action, 
      String? collectionChannel, 
      String? consentUUID, 
      String? consentVersion, 
      String? language, 
      String? name, 
      List<String>? purposeUUIDs, 
      String? uid,}){
    _action = action;
    _collectionChannel = collectionChannel;
    _consentUUID = consentUUID;
    _consentVersion = consentVersion;
    _language = language;
    _name = name;
    _purposeUUIDs = purposeUUIDs;
    _uid = uid;
}

  SubmitConsentBody.fromJson(dynamic json) {
    _action = json['action'];
    _collectionChannel = json['collectionChannel'];
    _consentUUID = json['consentUUID'];
    _consentVersion = json['consentVersion'];
    _language = json['language'];
    _name = json['name'];
    _purposeUUIDs = json['purposeUUIDs'] != null ? json['purposeUUIDs'].cast<String>() : [];
    _uid = json['uid'];
  }
  String? _action;
  String? _collectionChannel;
  String? _consentUUID;
  String? _consentVersion;
  String? _language;
  String? _name;
  List<String>? _purposeUUIDs;
  String? _uid;
SubmitConsentBody copyWith({  String? action,
  String? collectionChannel,
  String? consentUUID,
  String? consentVersion,
  String? language,
  String? name,
  List<String>? purposeUUIDs,
  String? uid,
}) => SubmitConsentBody(  action: action ?? _action,
  collectionChannel: collectionChannel ?? _collectionChannel,
  consentUUID: consentUUID ?? _consentUUID,
  consentVersion: consentVersion ?? _consentVersion,
  language: language ?? _language,
  name: name ?? _name,
  purposeUUIDs: purposeUUIDs ?? _purposeUUIDs,
  uid: uid ?? _uid,
);
  String? get action => _action;
  String? get collectionChannel => _collectionChannel;
  String? get consentUUID => _consentUUID;
  String? get consentVersion => _consentVersion;
  String? get language => _language;
  String? get name => _name;
  List<String>? get purposeUUIDs => _purposeUUIDs;
  String? get uid => _uid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['action'] = _action;
    map['collectionChannel'] = _collectionChannel;
    map['consentUUID'] = _consentUUID;
    map['consentVersion'] = _consentVersion;
    map['language'] = _language;
    map['name'] = _name;
    map['purposeUUIDs'] = _purposeUUIDs;
    map['uid'] = _uid;
    return map;
  }

}