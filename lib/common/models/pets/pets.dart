import 'package:json_annotation/json_annotation.dart';

import '../../../common/models/pets/models.dart';

part 'pets.g.dart';

@JsonSerializable()
class Pets {
  final int total;
  final List<Pet> items;

  Pets(this.total, this.items);

  factory Pets.fromJson(Map<String, dynamic> json) => _$PetsFromJson(json);
  Map<String, dynamic> toJson() => _$PetsToJson(this);
}
