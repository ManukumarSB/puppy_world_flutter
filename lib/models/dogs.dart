import 'package:puppy_world/models/dog.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dogs.g.dart';

@JsonSerializable()
class Dogs {
  final int total;
  final List<Dog> items;

  Dogs(this.total, this.items);

  factory Dogs.fromJson(Map<String, dynamic> json) => _$DogsFromJson(json);
  Map<String, dynamic> toJson() => _$DogsToJson(this);
}
