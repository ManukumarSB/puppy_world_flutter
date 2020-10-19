// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) {
  return UserDetails(
    json['profileImage'] as String,
    json['gender'] as String,
    json['dob'] as String,
    json['bio'] as String,
    json['mobile'] == null
        ? null
        : Mobile.fromJson(json['mobile'] as Map<String, dynamic>),
    json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'profileImage': instance.profileImage,
      'gender': instance.gender,
      'dob': instance.dob,
      'bio': instance.bio,
      'mobile': instance.mobile,
      'location': instance.location,
    };

Mobile _$MobileFromJson(Map<String, dynamic> json) {
  return Mobile(
    json['code'] as String,
    json['number'] as String,
  );
}

Map<String, dynamic> _$MobileToJson(Mobile instance) => <String, dynamic>{
      'code': instance.code,
      'number': instance.number,
    };
