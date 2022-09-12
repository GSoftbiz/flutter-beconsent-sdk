import 'package:json_annotation/json_annotation.dart';

part 'login_form.g.dart';

@JsonSerializable()
class LogInForm {
  @JsonKey(name: 'auth_type')
  final String? authType;
  @JsonKey(name: 'user_type')
  final String? userType;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? pin;
  @JsonKey(name: 'otp_secret')
  final String? otpSecret;
  final String? uuid;
  @JsonKey(name: 'access_token')
  final String? accessToken;


  LogInForm({this.authType, this.userType, this.phoneNumber, this.pin, this.otpSecret, this.uuid,this.accessToken});

  factory LogInForm.fromJson(Map<String, dynamic> json) =>
      _$LogInFormFromJson(json);
  Map<String, dynamic> toJson() => _$LogInFormToJson(this);
}
