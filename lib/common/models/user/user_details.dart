import 'package:json_annotation/json_annotation.dart';
import 'package:puppy_world/common/models/user/location.dart';

part 'user_details.g.dart';

@JsonSerializable()
class UserDetails {
  final String profileImage;
  final String gender;
  final String dob;
  final String bio;
  final Mobile mobile;
  final Location location;

  UserDetails(this.profileImage, this.gender, this.dob, this.bio, this.mobile,
      this.location);

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}

@JsonSerializable()
class Mobile {
  final String code;
  final String number;

  Mobile(this.code, this.number);

  factory Mobile.fromJson(Map<String, dynamic> json) => _$MobileFromJson(json);
  Map<String, dynamic> toJson() => _$MobileToJson(this);
}
