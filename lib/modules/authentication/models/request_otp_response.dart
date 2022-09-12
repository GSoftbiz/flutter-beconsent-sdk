import 'package:json_annotation/json_annotation.dart';

part 'request_otp_response.g.dart';

@JsonSerializable()
class RequestOTPResponse {
  final String ref;

  const RequestOTPResponse({
    required this.ref,

  });

  factory RequestOTPResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestOTPResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RequestOTPResponseToJson(this);
}
