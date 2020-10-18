import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../common/models/pets/models.dart';

part 'pet.g.dart';

@JsonSerializable()
class Pet {
  final String id;
  final String name;
  final String profileImageUrl;
  final VitalInformation vitalInfo;
  final Map imagesUrls;
  final List<BreedCharacteristic> breedCharacteristics;
  final List<String> description;
  final String sourceUrl;
  final List<Map> moreAbout;

  Pet(
      this.id,
      this.name,
      this.profileImageUrl,
      this.vitalInfo,
      this.imagesUrls,
      this.breedCharacteristics,
      this.description,
      this.sourceUrl,
      this.moreAbout);

  factory Pet.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);
  Map<String, dynamic> toJson() => _$PetToJson(this);

  String get getVitalBreedGroup => this.vitalInfo.breedGroup;

  String get getVitalLifeSpan =>
      '${removeDecimalZeroFormat(this.vitalInfo.lifeSpan.min)} - ${removeDecimalZeroFormat(this.vitalInfo.lifeSpan.max)} years';

  String get getVitalPetWeight =>
      '${removeDecimalZeroFormat(this.vitalInfo.weight.min)} - ${removeDecimalZeroFormat(this.vitalInfo.weight.max)} Kg';

  String get getVitalPetHeight =>
      '${removeDecimalZeroFormat(this.vitalInfo.height.min)} - ${removeDecimalZeroFormat(this.vitalInfo.height.max)} inches';

  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  List<dynamic> get getPetImages {
    var images = [];
    if (this.imagesUrls != null) {
      _getImages.forEach((url) {
        images.add(
          CachedNetworkImage(
            imageUrl: url,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                SizedBox(
                    height: 30,
                    width: 30,
                    child: Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    )),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        );
      });
      return images;
    }

    return [
      NetworkImage(
          'https://image.freepik.com/free-vector/404-error-page-banner-with-found-text-cute-Pet-background-error-404-concept-web-design-element_253396-497.jpg')
    ];
  }

  List<String> get _getImages {
    List<String> gallery = [];
    gallery.add(this.profileImageUrl);
    gallery.addAll(List<String>.from(this.imagesUrls['Gallery']));
    return gallery;
  }
}
