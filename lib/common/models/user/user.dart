import 'package:json_annotation/json_annotation.dart';

import './user_details.dart';
import './account_details.dart';
import './location.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String name;
  final String role;
  final String email;
  final UserDetails userDetails;

  final AccountDetails accountDetails;

  User(this.id, this.name, this.role, this.email, this.userDetails,
      this.accountDetails);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
