// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['name'] as String,
      json['surname'] as String,
      json['email'] as String,
      json['phone_number'] as String,
      json['picture_url'] as String,
      json['require'] == null
          ? null
          : Require.fromJson(json['require'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'picture_url': instance.pictureUrl,
      'require': instance.require,
    };

Require _$RequireFromJson(Map<String, dynamic> json) => Require(
      json['personal_information'] as bool,
      json['pin'] as bool,
    );

Map<String, dynamic> _$RequireToJson(Require instance) => <String, dynamic>{
      'personal_information': instance.personalInformation,
      'pin': instance.pin,
    };
