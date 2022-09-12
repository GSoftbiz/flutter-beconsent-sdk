import 'package:json_annotation/json_annotation.dart';

part 'request_otp_form.g.dart';

@JsonSerializable()
class RequestOTPForm {
  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  const RequestOTPForm({
    required this.phoneNumber,
  });

  factory RequestOTPForm.fromJson(Map<String, dynamic> json) =>
      _$RequestOTPFormFromJson(json);
  Map<String, dynamic> toJson() => _$RequestOTPFormToJson(this);
}
