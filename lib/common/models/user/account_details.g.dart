// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDetails _$AccountDetailsFromJson(Map<String, dynamic> json) {
  return AccountDetails(
    json['isMobileVerified'] as bool,
    json['isEmailVerified'] as bool,
    json['isNewsLetter'] as bool,
    json['isSuspended'] as bool,
    json['isMarkedForDeletion'] as bool,
    (json['followers'] as List)?.map((e) => e as String)?.toList(),
    (json['following'] as List)?.map((e) => e as String)?.toList(),
    (json['blackList'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$AccountDetailsToJson(AccountDetails instance) =>
    <String, dynamic>{
      'isMobileVerified': instance.isMobileVerified,
      'isEmailVerified': instance.isEmailVerified,
      'isNewsLetter': instance.isNewsLetter,
      'isSuspended': instance.isSuspended,
      'isMarkedForDeletion': instance.isMarkedForDeletion,
      'followers': instance.followers,
      'following': instance.following,
      'blackList': instance.blackList,
    };
