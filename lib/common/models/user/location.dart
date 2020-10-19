import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final String home;
  final String city;
  final String state;
  final String country;
  final String zip;
  final GeoCoordinate geoCoordinate;

  Location(this.home, this.city, this.state, this.country, this.zip,
      this.geoCoordinate);

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class GeoCoordinate {
  final double lat;
  final double long;

  GeoCoordinate(this.lat, this.long);

  factory GeoCoordinate.fromJson(Map<String, dynamic> json) =>
      _$GeoCoordinateFromJson(json);
  Map<String, dynamic> toJson() => _$GeoCoordinateToJson(this);
}
