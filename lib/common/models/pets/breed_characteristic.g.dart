// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breed_characteristic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreedCharacteristic _$BreedCharacteristicFromJson(Map<String, dynamic> json) {
  return BreedCharacteristic(
    json['title'] as String,
    json['rating'] as int,
    json['survey'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$BreedCharacteristicToJson(
        BreedCharacteristic instance) =>
    <String, dynamic>{
      'title': instance.title,
      'rating': instance.rating,
      'survey': instance.survey,
    };
