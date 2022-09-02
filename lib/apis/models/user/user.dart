import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends BaseModel {
  final int? id;
  final String? email;
  final String? username;
  final String? token;

  User({
    this.id,
    this.email,
    this.username,
    this.token,
  });

  @override
  User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
