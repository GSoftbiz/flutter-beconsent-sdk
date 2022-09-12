import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_form.g.dart';

@JsonSerializable()
class RefreshTokenForm {
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  const RefreshTokenForm(this.refreshToken);

  factory RefreshTokenForm.fromJson(Map<String, dynamic> json) => _$RefreshTokenFormFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshTokenFormToJson(this);
}
