import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_form.g.dart';

@JsonSerializable()
class VerifyOtpForm {

  final String ref;
  final String code;

  const VerifyOtpForm({
    required this.ref,
    required this.code,
  });

  factory VerifyOtpForm.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpFormFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyOtpFormToJson(this);
}
