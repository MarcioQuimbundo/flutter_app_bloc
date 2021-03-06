import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {

  String id, firstname, lastname, avatar;
  String token;

  User({this.token, this.avatar, this.firstname, this.id, this.lastname});

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}