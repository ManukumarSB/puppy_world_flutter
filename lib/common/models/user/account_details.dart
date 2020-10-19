import 'package:json_annotation/json_annotation.dart';

part 'account_details.g.dart';

@JsonSerializable()
class AccountDetails {
  final bool isMobileVerified;
  final bool isEmailVerified;
  final bool isNewsLetter;
  final bool isSuspended;
  final bool isMarkedForDeletion;
  final List<String> followers;
  final List<String> following;
  final List<String> blackList;

  AccountDetails(
    this.isMobileVerified,
    this.isEmailVerified,
    this.isNewsLetter,
    this.isSuspended,
    this.isMarkedForDeletion,
    this.followers,
    this.following,
    this.blackList,
  );

  factory AccountDetails.fromJson(Map<String, dynamic> json) =>
      _$AccountDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$AccountDetailsToJson(this);
}
