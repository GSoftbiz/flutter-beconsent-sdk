// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_with_social_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginWithSocialForm _$LoginWithSocialFormFromJson(Map<String, dynamic> json) =>
    LoginWithSocialForm(
      type: $enumDecode(_$SocialTypeEnumMap, json['type']),
      token: json['token'] as String,
    );

Map<String, dynamic> _$LoginWithSocialFormToJson(
        LoginWithSocialForm instance) =>
    <String, dynamic>{
      'type': _$SocialTypeEnumMap[instance.type],
      'token': instance.token,
    };

const _$SocialTypeEnumMap = {
  SocialType.facebook: 1,
  SocialType.google: 2,
  SocialType.apple: 3,
};
