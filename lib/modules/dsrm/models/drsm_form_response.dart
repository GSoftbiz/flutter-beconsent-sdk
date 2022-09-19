import 'package:flutter/widgets.dart';

class DSRMFormResponse {
  DSRMFormResponse({
    required this.id,
    required this.uuid,
    required this.title,
    required this.description,
    this.logo,
    required this.availableLanguage,
    required this.defaultLanguage,
    required this.rightRequests,
    required this.application,
    required this.version,
    required this.publishedAt,
    required this.workspaceId,
    required this.dsrmRequestFormId,
  });
  late final int id;
  late final String uuid;
  late final Title title;
  late final Description description;
  late final Null logo;
  late final List<String> availableLanguage;
  late final String defaultLanguage;
  late final List<RightRequests> rightRequests;
  late final Application application;
  late final String version;
  late final String publishedAt;
  late final int workspaceId;
  late final int dsrmRequestFormId;

  DSRMFormResponse.fromJson(Map<String, dynamic> json){
    id = json['id'];
    uuid = json['uuid'];
    title = Title.fromJson(json['title']);
    description = Description.fromJson(json['description']);
    logo = null;
    availableLanguage = List.castFrom<dynamic, String>(json['availableLanguage']);
    defaultLanguage = json['defaultLanguage'];
    rightRequests = List.from(json['rightRequests']).map((e)=>RightRequests.fromJson(e)).toList();
    application = Application.fromJson(json['application']);
    version = json['version'];
    publishedAt = json['publishedAt'];
    workspaceId = json['workspaceId'];
    dsrmRequestFormId = json['dsrmRequestFormId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['uuid'] = uuid;
    _data['title'] = title.toJson();
    _data['description'] = description.toJson();
    _data['logo'] = logo;
    _data['availableLanguage'] = availableLanguage;
    _data['defaultLanguage'] = defaultLanguage;
    _data['rightRequests'] = rightRequests.map((e)=>e.toJson()).toList();
    _data['application'] = application.toJson();
    _data['version'] = version;
    _data['publishedAt'] = publishedAt;
    _data['workspaceId'] = workspaceId;
    _data['dsrmRequestFormId'] = dsrmRequestFormId;
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

class RightRequests {
  RightRequests({
    required this.id,
    required this.uuid,
    required this.workspaceId,
    required this.rightRequestName,
    required this.options,
    required this.hasFeeCharge,
    required this.enableFeeCharge,
    required this.feeChargeAmount,
    required this.requestType,
  });
  late final int id;
  late final String uuid;
  late final int workspaceId;
  late final RightRequestName rightRequestName;
  late final List<Options> options;
  late final bool hasFeeCharge;
  late final bool enableFeeCharge;
  late final int? feeChargeAmount;
  late final String requestType;

  String getTitle(BuildContext context){
    if(Localizations.localeOf(context).languageCode == "th"){
      if(rightRequestName.th.isNotEmpty){
        return rightRequestName.th;
      }
    }
    if(rightRequestName.en.isEmpty){
      return rightRequestName.th;
    }
    return rightRequestName.en;
  }

  RightRequests.fromJson(Map<String, dynamic> json){
    id = json['id'];
    uuid = json['uuid'];
    workspaceId = json['workspaceId'];
    rightRequestName = RightRequestName.fromJson(json['rightRequestName']);
    options = List.from(json['options']).map((e)=>Options.fromJson(e)).toList();
    hasFeeCharge = json['hasFeeCharge'];
    enableFeeCharge = json['enableFeeCharge'];
    feeChargeAmount = json['feeChargeAmount'];
    requestType = json['requestType'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['uuid'] = uuid;
    _data['workspaceId'] = workspaceId;
    _data['rightRequestName'] = rightRequestName.toJson();
    _data['options'] = options.map((e)=>e.toJson()).toList();
    _data['hasFeeCharge'] = hasFeeCharge;
    _data['enableFeeCharge'] = enableFeeCharge;
    _data['feeChargeAmount'] = feeChargeAmount;
    _data['requestType'] = requestType;
    return _data;
  }
}

class RightRequestName {
  RightRequestName({
    required this.en,
    required this.th,
  });
  late final String en;
  late final String th;

  RightRequestName.fromJson(Map<String, dynamic> json){
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

class Options {
  Options({
    required this.name,
    required this.enable,
  });
  late final OptionName name;
  late final bool enable;

  String getTitle(BuildContext context){
    if(Localizations.localeOf(context).languageCode == "th"){
      if(name.th.isNotEmpty){
        return name.th;
      }
    }
    if(name.en.isEmpty){
      return name.th;
    }
    return name.en;
  }

  Options.fromJson(Map<String, dynamic> json){
    name = OptionName.fromJson(json['name']);
    enable = json['enable'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name.toJson();
    _data['enable'] = enable;
    return _data;
  }
}

class OptionName {
  OptionName({
    required this.en,
    required this.th,
  });
  late final String en;
  late final String th;

  OptionName.fromJson(Map<String, dynamic> json){
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
  late final OptionName name;
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
    name = OptionName.fromJson(json['name']);
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