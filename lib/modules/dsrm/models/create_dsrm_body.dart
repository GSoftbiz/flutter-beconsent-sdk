class CreateDSRMBody {
  CreateDSRMBody({
    required this.additionalRequestOption,
    required this.collectionChannel,
    required this.dsrmRequestFormId,
    required this.dsrmRequestFormUUID,
    required this.dsrmRequestFormVersion,
    required this.guardianInformation,
    required this.hasGuardian,
    required this.identityValidation,
    required this.requestDetail,
    required this.rightRequestId,
    required this.rightRequestUUID,
    required this.selectedRightRequestOptions,
    required this.uid,
  });
  late final String additionalRequestOption;
  late final String collectionChannel;
  late final int dsrmRequestFormId;
  late final String dsrmRequestFormUUID;
  late final String dsrmRequestFormVersion;
  late final GuardianInformation guardianInformation;
  late final bool hasGuardian;
  late final IdentityValidation identityValidation;
  late final String requestDetail;
  late final int rightRequestId;
  late final String rightRequestUUID;
  late final List<int> selectedRightRequestOptions;
  late final String uid;

  CreateDSRMBody.fromJson(Map<String, dynamic> json){
    additionalRequestOption = json['additionalRequestOption'];
    collectionChannel = json['collectionChannel'];
    dsrmRequestFormId = json['dsrmRequestFormId'];
    dsrmRequestFormUUID = json['dsrmRequestFormUUID'];
    dsrmRequestFormVersion = json['dsrmRequestFormVersion'];
    guardianInformation = GuardianInformation.fromJson(json['guardianInformation']);
    hasGuardian = json['hasGuardian'];
    identityValidation = IdentityValidation.fromJson(json['identityValidation']);
    requestDetail = json['requestDetail'];
    rightRequestId = json['rightRequestId'];
    rightRequestUUID = json['rightRequestUUID'];
    selectedRightRequestOptions = List.castFrom<dynamic, int>(json['selectedRightRequestOptions']);
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['additionalRequestOption'] = additionalRequestOption;
    _data['collectionChannel'] = collectionChannel;
    _data['dsrmRequestFormId'] = dsrmRequestFormId;
    _data['dsrmRequestFormUUID'] = dsrmRequestFormUUID;
    _data['dsrmRequestFormVersion'] = dsrmRequestFormVersion;
    _data['guardianInformation'] = guardianInformation.toJson();
    _data['hasGuardian'] = hasGuardian;
    _data['identityValidation'] = identityValidation.toJson();
    _data['requestDetail'] = requestDetail;
    _data['rightRequestId'] = rightRequestId;
    _data['rightRequestUUID'] = rightRequestUUID;
    _data['selectedRightRequestOptions'] = selectedRightRequestOptions;
    _data['uid'] = uid;
    return _data;
  }
}

class GuardianInformation {
  GuardianInformation({
    required this.country,
    required this.email,
    required this.firstName,
    required this.lastName,
  });
  late final String country;
  late final String email;
  late final String firstName;
  late final String lastName;

  GuardianInformation.fromJson(Map<String, dynamic> json){
    country = json['country'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['country'] = country;
    _data['email'] = email;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    return _data;
  }
}

class IdentityValidation {
  IdentityValidation({
    required this.country,
    required this.email,
    required this.firstName,
    required this.lastName,
  });
  late final String country;
  late final String email;
  late final String firstName;
  late final String lastName;

  IdentityValidation.fromJson(Map<String, dynamic> json){
    country = json['country'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['country'] = country;
    _data['email'] = email;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    return _data;
  }
}