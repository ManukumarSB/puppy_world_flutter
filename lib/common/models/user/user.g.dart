// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as String,
    json['name'] as String,
    json['role'] as String,
    json['email'] as String,
    json['userDetails'] == null
        ? null
        : UserDetails.fromJson(json['userDetails'] as Map<String, dynamic>),
    json['accountDetails'] == null
        ? null
        : AccountDetails.fromJson(
            json['accountDetails'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
      'email': instance.email,
      'userDetails': instance.userDetails,
      'accountDetails': instance.accountDetails,
    };
