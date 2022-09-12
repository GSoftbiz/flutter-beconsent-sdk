// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogInForm _$LogInFormFromJson(Map<String, dynamic> json) => LogInForm(
      authType: json['auth_type'] as String?,
      userType: json['user_type'] as String?,
      phoneNumber: json['phone_number'] as String?,
      pin: json['pin'] as String?,
      otpSecret: json['otp_secret'] as String?,
      uuid: json['uuid'] as String?,
      accessToken: json['access_token'] as String?,
    );

Map<String, dynamic> _$LogInFormToJson(LogInForm instance) => <String, dynamic>{
      'auth_type': instance.authType,
      'user_type': instance.userType,
      'phone_number': instance.phoneNumber,
      'pin': instance.pin,
      'otp_secret': instance.otpSecret,
      'uuid': instance.uuid,
      'access_token': instance.accessToken,
    };
