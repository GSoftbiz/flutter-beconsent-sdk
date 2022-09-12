// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogOutForm _$LogOutFormFromJson(Map<String, dynamic> json) => LogOutForm(
      json['refresh_token'] as String,
      json['uuild'] as String,
    );

Map<String, dynamic> _$LogOutFormToJson(LogOutForm instance) =>
    <String, dynamic>{
      'refresh_token': instance.refreshToken,
      'uuild': instance.uuid,
    };
