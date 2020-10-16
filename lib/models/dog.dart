import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:puppy_world/models/breed_characteristic.dart';
import 'package:puppy_world/models/vital_information.dart';

part 'dog.g.dart';

@JsonSerializable()
class Dog {
  final String id;
  final String name;
  final String profileImageUrl;
  final VitalInformation vitalInfo;
  final Map imagesUrls;
  final List<BreedCharacteristic> breedCharacteristics;
  final List<String> description;
  final String sourceUrl;
  final List<Map> moreAbout;

  Dog(
      this.id,
      this.name,
      this.profileImageUrl,
      this.vitalInfo,
      this.imagesUrls,
      this.breedCharacteristics,
      this.description,
      this.sourceUrl,
      this.moreAbout);

  factory Dog.fromJson(Map<String, dynamic> json) => _$DogFromJson(json);
  Map<String, dynamic> toJson() => _$DogToJson(this);

  String get getVitalBreedGroup => this.vitalInfo.breedGroup;

  String get getVitalLifeSpan =>
      '${removeDecimalZeroFormat(this.vitalInfo.lifeSpan.min)} - ${removeDecimalZeroFormat(this.vitalInfo.lifeSpan.max)} years';

  String get getVitalDogWeight =>
      '${removeDecimalZeroFormat(this.vitalInfo.weight.min)} - ${removeDecimalZeroFormat(this.vitalInfo.weight.max)} Kg';

  String get getVitalDogHeight =>
      '${removeDecimalZeroFormat(this.vitalInfo.height.min)} - ${removeDecimalZeroFormat(this.vitalInfo.height.max)} inches';

  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  List<dynamic> get getDogImages {
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
          'https://image.freepik.com/free-vector/404-error-page-banner-with-found-text-cute-dog-background-error-404-concept-web-design-element_253396-497.jpg')
    ];
  }

  List<String> get _getImages {
    List<String> gallery = [];
    gallery.add(this.profileImageUrl);
    gallery.addAll(List<String>.from(this.imagesUrls['Gallery']));
    return gallery;
  }
}
