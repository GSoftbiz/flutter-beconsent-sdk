import 'package:json_annotation/json_annotation.dart';

part 'logout_form.g.dart';

@JsonSerializable()
class LogOutForm {
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'uuild')
  final String uuid;

  LogOutForm(this.refreshToken, this.uuid);

  factory LogOutForm.fromJson(Map<String, dynamic> json) =>
      _$LogOutFormFromJson(json);
  Map<String, dynamic> toJson() => _$LogOutFormToJson(this);
}
