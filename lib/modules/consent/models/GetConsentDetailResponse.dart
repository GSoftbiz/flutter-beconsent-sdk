import 'package:flutter/widgets.dart';

class GetConsentDetailResponse {
  GetConsentDetailResponse({
    required this.id,
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.application,
    required this.name,
    required this.effectiveAsOfBegin,
    required this.effectiveAsOfEnd,
    required this.title,
    required this.description,
    required this.privacyLinkName,
    required this.availableLanguage,
    required this.defaultLanguage,
    required this.linkPolicy,
    required this.logo,
    required this.showPrivacyPolicyLink,
    this.customApiDescription,
    required this.latestVersion,
    required this.version,
    required this.template,
    required this.collectionChannel,
    required this.publishedAt,
    required this.workspaceId,
    required this.consentId,
    required this.purposes,
    required this.consentUUID,
    required this.workspaceUUID,
  });
  late final int id;
  late final String uuid;
  late final String createdAt;
  late final String updatedAt;
  late final Application application;
  late final String name;
  late final String effectiveAsOfBegin;
  late final String effectiveAsOfEnd;
  late final Title title;
  late final Description description;
  late final PrivacyLinkName privacyLinkName;
  late final List<String> availableLanguage;
  late final String defaultLanguage;
  late final String linkPolicy;
  late final String logo;
  late final bool showPrivacyPolicyLink;
  late final Null customApiDescription;
  late final String latestVersion;
  late final String version;
  late final Template template;
  late final String collectionChannel;
  late final String publishedAt;
  late final int workspaceId;
  late final int consentId;
  late final List<Purposes> purposes;
  late final String consentUUID;
  late final String workspaceUUID;

  String getTitle(BuildContext context){
    if(Localizations.localeOf(context).languageCode == "th"){
       if(title.th.isNotEmpty){
         return title.th;
       }
    }
    if(title.en.isEmpty){
      return title.th;
    }
    return title.en;
  }

  String getDesc(BuildContext context){
    if(Localizations.localeOf(context).languageCode == "th"){
      if(description.th.isNotEmpty){
        return description.th;
      }
    }
    if(description.en.isEmpty){
      return description.th;
    }
    return description.en;
  }

  GetConsentDetailResponse.fromJson(Map<String, dynamic> json){
    id = json['id'];
    uuid = json['uuid'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    application = Application.fromJson(json['application']);
    name = json['name'];
    effectiveAsOfBegin = json['effectiveAsOfBegin'];
    effectiveAsOfEnd = json['effectiveAsOfEnd'];
    title = Title.fromJson(json['title']);
    description = Description.fromJson(json['description']);
    privacyLinkName = PrivacyLinkName.fromJson(json['privacyLinkName']);
    availableLanguage = List.castFrom<dynamic, String>(json['availableLanguage']);
    defaultLanguage = json['defaultLanguage'];
    linkPolicy = json['linkPolicy'];
    logo = json['logo'];
    showPrivacyPolicyLink = json['showPrivacyPolicyLink'];
    customApiDescription = null;
    latestVersion = json['latestVersion'];
    version = json['version'];
    template = Template.fromJson(json['template']);
    collectionChannel = json['collectionChannel'];
    publishedAt = json['publishedAt'];
    workspaceId = json['workspaceId'];
    consentId = json['consentId'];
    purposes = List.from(json['purposes']).map((e)=>Purposes.fromJson(e)).toList();
    consentUUID = json['consentUUID'];
    workspaceUUID = json['workspaceUUID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['uuid'] = uuid;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['application'] = application.toJson();
    _data['name'] = name;
    _data['effectiveAsOfBegin'] = effectiveAsOfBegin;
    _data['effectiveAsOfEnd'] = effectiveAsOfEnd;
    _data['title'] = title.toJson();
    _data['description'] = description.toJson();
    _data['privacyLinkName'] = privacyLinkName.toJson();
    _data['availableLanguage'] = availableLanguage;
    _data['defaultLanguage'] = defaultLanguage;
    _data['linkPolicy'] = linkPolicy;
    _data['logo'] = logo;
    _data['showPrivacyPolicyLink'] = showPrivacyPolicyLink;
    _data['customApiDescription'] = customApiDescription;
    _data['latestVersion'] = latestVersion;
    _data['version'] = version;
    _data['template'] = template.toJson();
    _data['collectionChannel'] = collectionChannel;
    _data['publishedAt'] = publishedAt;
    _data['workspaceId'] = workspaceId;
    _data['consentId'] = consentId;
    _data['purposes'] = purposes.map((e)=>e.toJson()).toList();
    _data['consentUUID'] = consentUUID;
    _data['workspaceUUID'] = workspaceUUID;
    return _data;
  }
}

class Application {
  Application({
    required this.id,
    required this.uuid,
    required this.workspaceId,
    required this.name,
    required this.description,
    required this.sourceOfData,
    this.otherSource,
    required this.deactivate,
    required this.dataController,
  });
  late final int id;
  late final String uuid;
  late final int workspaceId;
  late final String name;
  late final String description;
  late final bool sourceOfData;
  late final Null otherSource;
  late final bool deactivate;
  late final DataController dataController;

  Application.fromJson(Map<String, dynamic> json){
    id = json['id'];
    uuid = json['uuid'];
    workspaceId = json['workspaceId'];
    name = json['name'];
    description = json['description'];
    sourceOfData = json['sourceOfData'];
    otherSource = null;
    deactivate = json['deactivate'];
    dataController = DataController.fromJson(json['dataController']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['uuid'] = uuid;
    _data['workspaceId'] = workspaceId;
    _data['name'] = name;
    _data['description'] = description;
    _data['sourceOfData'] = sourceOfData;
    _data['otherSource'] = otherSource;
    _data['deactivate'] = deactivate;
    _data['dataController'] = dataController.toJson();
    return _data;
  }
}

class DataController {
  DataController({
    required this.id,
    required this.uuid,
    required this.workspaceId,
    required this.name,
    required this.contactPerson,
    required this.address,
    required this.country,
    required this.phone,
    required this.email,
    required this.website,
    required this.linkPolicy,
    required this.logo,
  });
  late final int id;
  late final String uuid;
  late final int workspaceId;
  late final Name name;
  late final String contactPerson;
  late final String address;
  late final String country;
  late final String phone;
  late final String email;
  late final String website;
  late final String linkPolicy;
  late final String logo;

  DataController.fromJson(Map<String, dynamic> json){
    id = json['id'];
    uuid = json['uuid'];
    workspaceId = json['workspaceId'];
    name = Name.fromJson(json['name']);
    contactPerson = json['contactPerson'];
    address = json['address'];
    country = json['country'];
    phone = json['phone'];
    email = json['email'];
    website = json['website'];
    linkPolicy = json['linkPolicy'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['uuid'] = uuid;
    _data['workspaceId'] = workspaceId;
    _data['name'] = name.toJson();
    _data['contactPerson'] = contactPerson;
    _data['address'] = address;
    _data['country'] = country;
    _data['phone'] = phone;
    _data['email'] = email;
    _data['website'] = website;
    _data['linkPolicy'] = linkPolicy;
    _data['logo'] = logo;
    return _data;
  }
}

class Name {
  Name({
    required this.en,
    required this.th,
  });
  late final String en;
  late final String th;

  Name.fromJson(Map<String, dynamic> json){
    en = json['en'];
    th = json['th'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['en'] = en;
    _data['th'] = th;
    return _data;
  }
}

class Title {
  Title({
    required this.en,
    required this.th,
  });
  late final String en;
  late final String th;

  Title.fromJson(Map<String, dynamic> json){
    en = json['en'];
    th = json['th'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['en'] = en;
    _data['th'] = th;
    return _data;
  }
}

class Description {
  Description({
    required this.en,
    required this.th,
  });
  late final String en;
  late final String th;

  Description.fromJson(Map<String, dynamic> json){
    en = json['en'];
    th = json['th'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['en'] = en;
    _data['th'] = th;
    return _data;
  }
}

class PrivacyLinkName {
  PrivacyLinkName({
    required this.en,
    required this.th,
  });
  late final String en;
  late final String th;

  PrivacyLinkName.fromJson(Map<String, dynamic> json){
    en = json['en'];
    th = json['th'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['en'] = en;
    _data['th'] = th;
    return _data;
  }
}

class Template {
  Template({
    required this.themeColor,
    required this.modal,
    required this.showLogo,
  });
  late final String themeColor;
  late final Modal modal;
  late final bool showLogo;

  Template.fromJson(Map<String, dynamic> json){
    themeColor = json['themeColor'];
    modal = Modal.fromJson(json['modal']);
    showLogo = json['showLogo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['themeColor'] = themeColor;
    _data['modal'] = modal.toJson();
    _data['showLogo'] = showLogo;
    return _data;
  }
}

class Modal {
  Modal({
    required this.backgroundColor,
    required this.textColor,
    required this.acceptButtonBackgroundColor,
    required this.acceptButtonTextColor,
    required this.rejectButtonBackgroundColor,
    required this.rejectButtonTextColor,
  });
  late final String backgroundColor;
  late final String textColor;
  late final String acceptButtonBackgroundColor;
  late final String acceptButtonTextColor;
  late final String rejectButtonBackgroundColor;
  late final String rejectButtonTextColor;

  Modal.fromJson(Map<String, dynamic> json){
    backgroundColor = json['backgroundColor'];
    textColor = json['textColor'];
    acceptButtonBackgroundColor = json['acceptButtonBackgroundColor'];
    acceptButtonTextColor = json['acceptButtonTextColor'];
    rejectButtonBackgroundColor = json['rejectButtonBackgroundColor'];
    rejectButtonTextColor = json['rejectButtonTextColor'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['backgroundColor'] = backgroundColor;
    _data['textColor'] = textColor;
    _data['acceptButtonBackgroundColor'] = acceptButtonBackgroundColor;
    _data['acceptButtonTextColor'] = acceptButtonTextColor;
    _data['rejectButtonBackgroundColor'] = rejectButtonBackgroundColor;
    _data['rejectButtonTextColor'] = rejectButtonTextColor;
    return _data;
  }
}

class Purposes {
  Purposes({
    required this.id,
    required this.uuid,
    required this.purposeCategories,
    required this.piiCategories,
    required this.personnel,
    required this.title,
    required this.description,
    required this.availableLanguage,
    required this.defaultLanguage,
    required this.primary,
    required this.dataSubjectGroup,
    required this.isConsentPurpose,
    required this.lawfulBases,
    this.lawfulBasisDescription,
    required this.isInternalApplication,
    this.internalApplication,
    required this.thirdPartyDisclosure,
    this.thirdPartyName,
    required this.thirdPartyCountry,
    this.thirdPartyContract,
    this.dataRetentionDescription,
    required this.storage,
    required this.securityMeasure,
    required this.version,
    required this.publishedAt,
    required this.workspaceId,
    required this.purposeId,
    required this.order,
  });
  late final int id;
  late final String uuid;
  late final List<PurposeCategories> purposeCategories;
  late final List<PiiCategories> piiCategories;
  late final Personnel personnel;
  late final Title title;
  late final Description description;
  late final List<String> availableLanguage;
  late final String defaultLanguage;
  late final bool primary;
  late final String dataSubjectGroup;
  late final bool isConsentPurpose;
  late final List<dynamic> lawfulBases;
  late final Null lawfulBasisDescription;
  late final bool isInternalApplication;
  late final Null internalApplication;
  late final bool thirdPartyDisclosure;
  late final Null thirdPartyName;
  late final String thirdPartyCountry;
  late final Null thirdPartyContract;
  late final Null dataRetentionDescription;
  late final String storage;
  late final String securityMeasure;
  late final String version;
  late final String publishedAt;
  late final int workspaceId;
  late final int purposeId;
  late final int order;
  String getTitle(BuildContext context){
    if(Localizations.localeOf(context).languageCode == "th"){
      if(title.th.isNotEmpty){
        return title.th;
      }
    }
    if(title.en.isEmpty){
      return title.th;
    }
    return title.en;
  }

  String getDesc(BuildContext context){
    if(Localizations.localeOf(context).languageCode == "th"){
      if(description.th.isNotEmpty){
        return description.th;
      }
    }
    if(description.en.isEmpty){
      return description.th;
    }
    return description.en;
  }

  Purposes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    uuid = json['uuid'];
    purposeCategories = List.from(json['purposeCategories']).map((e)=>PurposeCategories.fromJson(e)).toList();
    piiCategories = List.from(json['piiCategories']).map((e)=>PiiCategories.fromJson(e)).toList();
    personnel = Personnel.fromJson(json['personnel']);
    title = Title.fromJson(json['title']);
    description = Description.fromJson(json['description']);
    availableLanguage = List.castFrom<dynamic, String>(json['availableLanguage']);
    defaultLanguage = json['defaultLanguage'];
    primary = json['primary'];
    dataSubjectGroup = json['dataSubjectGroup'];
    isConsentPurpose = json['isConsentPurpose'];
    lawfulBases = List.castFrom<dynamic, dynamic>(json['lawfulBases']);
    lawfulBasisDescription = null;
    isInternalApplication = json['isInternalApplication'];
    internalApplication = null;
    thirdPartyDisclosure = json['thirdPartyDisclosure'];
    thirdPartyName = null;
    thirdPartyCountry = json['thirdPartyCountry'];
    thirdPartyContract = null;
    dataRetentionDescription = null;
    storage = json['storage'];
    securityMeasure = json['securityMeasure'];
    version = json['version'];
    publishedAt = json['publishedAt'];
    workspaceId = json['workspaceId'];
    purposeId = json['purposeId'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['uuid'] = uuid;
    _data['purposeCategories'] = purposeCategories.map((e)=>e.toJson()).toList();
    _data['piiCategories'] = piiCategories.map((e)=>e.toJson()).toList();
    _data['personnel'] = personnel.toJson();
    _data['title'] = title.toJson();
    _data['description'] = description.toJson();
    _data['availableLanguage'] = availableLanguage;
    _data['defaultLanguage'] = defaultLanguage;
    _data['primary'] = primary;
    _data['dataSubjectGroup'] = dataSubjectGroup;
    _data['isConsentPurpose'] = isConsentPurpose;
    _data['lawfulBases'] = lawfulBases;
    _data['lawfulBasisDescription'] = lawfulBasisDescription;
    _data['isInternalApplication'] = isInternalApplication;
    _data['internalApplication'] = internalApplication;
    _data['thirdPartyDisclosure'] = thirdPartyDisclosure;
    _data['thirdPartyName'] = thirdPartyName;
    _data['thirdPartyCountry'] = thirdPartyCountry;
    _data['thirdPartyContract'] = thirdPartyContract;
    _data['dataRetentionDescription'] = dataRetentionDescription;
    _data['storage'] = storage;
    _data['securityMeasure'] = securityMeasure;
    _data['version'] = version;
    _data['publishedAt'] = publishedAt;
    _data['workspaceId'] = workspaceId;
    _data['purposeId'] = purposeId;
    _data['order'] = order;
    return _data;
  }
}

class PurposeCategories {
  PurposeCategories({
    required this.id,
    required this.uuid,
    required this.workspaceId,
    required this.name,
    required this.description,
    required this.availableLanguage,
    required this.defaultLanguage,
  });
  late final int id;
  late final String uuid;
  late final int workspaceId;
  late final Name name;
  late final Description description;
  late final List<String> availableLanguage;
  late final String defaultLanguage;

  PurposeCategories.fromJson(Map<String, dynamic> json){
    id = json['id'];
    uuid = json['uuid'];
    workspaceId = json['workspaceId'];
    name = Name.fromJson(json['name']);
    description = Description.fromJson(json['description']);
    availableLanguage = List.castFrom<dynamic, String>(json['availableLanguage']);
    defaultLanguage = json['defaultLanguage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['uuid'] = uuid;
    _data['workspaceId'] = workspaceId;
    _data['name'] = name.toJson();
    _data['description'] = description.toJson();
    _data['availableLanguage'] = availableLanguage;
    _data['defaultLanguage'] = defaultLanguage;
    return _data;
  }
}

class PiiCategories {
  PiiCategories({
    required this.id,
    required this.uuid,
    required this.workspaceId,
    required this.name,
    required this.description,
    required this.availableLanguage,
    required this.defaultLanguage,
  });
  late final int id;
  late final String uuid;
  late final int workspaceId;
  late final Name name;
  late final Description description;
  late final List<String> availableLanguage;
  late final String defaultLanguage;

  PiiCategories.fromJson(Map<String, dynamic> json){
    id = json['id'];
    uuid = json['uuid'];
    workspaceId = json['workspaceId'];
    name = Name.fromJson(json['name']);
    description = Description.fromJson(json['description']);
    availableLanguage = List.castFrom<dynamic, String>(json['availableLanguage']);
    defaultLanguage = json['defaultLanguage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['uuid'] = uuid;
    _data['workspaceId'] = workspaceId;
    _data['name'] = name.toJson();
    _data['description'] = description.toJson();
    _data['availableLanguage'] = availableLanguage;
    _data['defaultLanguage'] = defaultLanguage;
    return _data;
  }
}

class Personnel {
  Personnel({
    required this.id,
    required this.uuid,
    required this.name,
    required this.position,
    required this.phone,
    required this.email,
    required this.logo,
  });
  late final int id;
  late final String uuid;
  late final String name;
  late final String position;
  late final String phone;
  late final String email;
  late final String logo;

  Personnel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    position = json['position'];
    phone = json['phone'];
    email = json['email'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['uuid'] = uuid;
    _data['name'] = name;
    _data['position'] = position;
    _data['phone'] = phone;
    _data['email'] = email;
    _data['logo'] = logo;
    return _data;
  }
}