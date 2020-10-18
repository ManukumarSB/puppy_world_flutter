import 'package:json_annotation/json_annotation.dart';

part 'breed_characteristic.g.dart';

@JsonSerializable()
class BreedCharacteristic {
  final String title;
  final int rating;
  final Map survey;

  BreedCharacteristic(this.title, this.rating, this.survey);

  factory BreedCharacteristic.fromJson(Map<String, dynamic> json) =>
      _$BreedCharacteristicFromJson(json);
  Map<String, dynamic> toJson() => _$BreedCharacteristicToJson(this);
}
