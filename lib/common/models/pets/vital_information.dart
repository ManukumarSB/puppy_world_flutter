import 'package:json_annotation/json_annotation.dart';

part 'vital_information.g.dart';

@JsonSerializable()
class VitalInformation {
  final String breedGroup;
  final MinMax height;
  final MinMax weight;
  final MinMax lifeSpan;

  VitalInformation(this.breedGroup, this.height, this.weight, this.lifeSpan);

  factory VitalInformation.fromJson(Map<String, dynamic> json) =>
      _$VitalInformationFromJson(json);
  Map<String, dynamic> toJson() => _$VitalInformationToJson(this);
}

@JsonSerializable()
class MinMax {
  final double min;
  final double max;

  MinMax(this.min, this.max);

  factory MinMax.fromJson(Map<String, dynamic> json) => _$MinMaxFromJson(json);
  Map<String, dynamic> toJson() => _$MinMaxToJson(this);
}
