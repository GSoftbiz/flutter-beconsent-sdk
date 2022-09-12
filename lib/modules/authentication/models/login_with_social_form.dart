import 'package:json_annotation/json_annotation.dart';

part 'login_with_social_form.g.dart';

enum SocialType {
  @JsonValue(1)
  facebook,
  @JsonValue(2)
  google,
  @JsonValue(3)
  apple,
}

@JsonSerializable()
class LoginWithSocialForm {
  final SocialType type;
  final String token;

  const LoginWithSocialForm({
    required this.type,
    required this.token,
  });

  factory LoginWithSocialForm.fromJson(Map<String, dynamic> json) =>
      _$LoginWithSocialFormFromJson(json);
  Map<String, dynamic> toJson() => _$LoginWithSocialFormToJson(this);
}
