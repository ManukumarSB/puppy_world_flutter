// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pet _$PetFromJson(Map<String, dynamic> json) {
  return Pet(
    json['id'] as String,
    json['name'] as String,
    json['profileImageUrl'] as String,
    json['vitalInfo'] == null
        ? null
        : VitalInformation.fromJson(json['vitalInfo'] as Map<String, dynamic>),
    json['imagesUrls'] as Map<String, dynamic>,
    (json['breedCharacteristics'] as List)
        ?.map((e) => e == null
            ? null
            : BreedCharacteristic.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['description'] as List)?.map((e) => e as String)?.toList(),
    json['sourceUrl'] as String,
    (json['moreAbout'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList(),
  );
}

Map<String, dynamic> _$PetToJson(Pet instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profileImageUrl': instance.profileImageUrl,
      'vitalInfo': instance.vitalInfo,
      'imagesUrls': instance.imagesUrls,
      'breedCharacteristics': instance.breedCharacteristics,
      'description': instance.description,
      'sourceUrl': instance.sourceUrl,
      'moreAbout': instance.moreAbout,
    };
