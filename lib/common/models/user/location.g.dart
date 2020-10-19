// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    json['home'] as String,
    json['city'] as String,
    json['state'] as String,
    json['country'] as String,
    json['zip'] as String,
    json['geoCoordinate'] == null
        ? null
        : GeoCoordinate.fromJson(json['geoCoordinate'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'home': instance.home,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'zip': instance.zip,
      'geoCoordinate': instance.geoCoordinate,
    };

GeoCoordinate _$GeoCoordinateFromJson(Map<String, dynamic> json) {
  return GeoCoordinate(
    (json['lat'] as num)?.toDouble(),
    (json['long'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$GeoCoordinateToJson(GeoCoordinate instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
    };
