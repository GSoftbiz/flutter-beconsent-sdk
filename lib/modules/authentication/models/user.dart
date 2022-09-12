import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String surname;
  final String email;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'picture_url')
  final String pictureUrl;
  final Require? require;

  User(this.name, this.surname, this.email, this.phoneNumber, this.pictureUrl,this.require);



  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Require {
  @JsonKey(name: 'personal_information')
  final bool personalInformation;
  final bool pin;

  Require(this.personalInformation, this.pin);

  factory Require.fromJson(Map<String, dynamic> json) => _$RequireFromJson(json);
  Map<String, dynamic> toJson() => _$RequireToJson(this);
}
