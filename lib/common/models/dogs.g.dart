// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dogs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dogs _$DogsFromJson(Map<String, dynamic> json) {
  return Dogs(
    json['total'] as int,
    (json['items'] as List)
        ?.map((e) => e == null ? null : Dog.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DogsToJson(Dogs instance) => <String, dynamic>{
      'total': instance.total,
      'items': instance.items,
    };
