// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pets _$PetsFromJson(Map<String, dynamic> json) {
  return Pets(
    json['total'] as int,
    (json['items'] as List)
        ?.map((e) => e == null ? null : Pet.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PetsToJson(Pets instance) => <String, dynamic>{
      'total': instance.total,
      'items': instance.items,
    };
