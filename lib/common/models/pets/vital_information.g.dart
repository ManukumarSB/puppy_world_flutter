// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vital_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VitalInformation _$VitalInformationFromJson(Map<String, dynamic> json) {
  return VitalInformation(
    json['breedGroup'] as String,
    json['height'] == null
        ? null
        : MinMax.fromJson(json['height'] as Map<String, dynamic>),
    json['weight'] == null
        ? null
        : MinMax.fromJson(json['weight'] as Map<String, dynamic>),
    json['lifeSpan'] == null
        ? null
        : MinMax.fromJson(json['lifeSpan'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VitalInformationToJson(VitalInformation instance) =>
    <String, dynamic>{
      'breedGroup': instance.breedGroup,
      'height': instance.height,
      'weight': instance.weight,
      'lifeSpan': instance.lifeSpan,
    };

MinMax _$MinMaxFromJson(Map<String, dynamic> json) {
  return MinMax(
    (json['min'] as num)?.toDouble(),
    (json['max'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$MinMaxToJson(MinMax instance) => <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };
