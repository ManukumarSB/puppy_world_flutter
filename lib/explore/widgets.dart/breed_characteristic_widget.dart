import 'package:flutter/material.dart';

import '../../common/models/models.dart';
import '../../explore/providers.dart/providers.dart';

class BreedCharacteristicWidget extends StatelessWidget {
  final DogProfileProvider dogDetailsProvider;
  const BreedCharacteristicWidget({this.dogDetailsProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Breed Characteristic :',
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return _buildCharacteristicCard(
                      dogDetailsProvider.dog.breedCharacteristics[index],
                      context);
                },
                itemCount: dogDetailsProvider.dog.breedCharacteristics.length,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCharacteristicCard(
      BreedCharacteristic breedCharacteristic, BuildContext context) {
    List<String> surveyKeys = [];
    List<int> surveyDogDetailsProviders = [];
    breedCharacteristic.survey.forEach((key, dogDetailsProvider) {
      surveyKeys.add(key);
      surveyDogDetailsProviders.add(dogDetailsProvider);
    });
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  breedCharacteristic.title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return Icon(
                    index < breedCharacteristic.rating
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.yellow[800],
                  );
                }),
              ),
            ],
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return _buildSurveyStat(
                  surveyKeys[index], surveyDogDetailsProviders[index], context);
            },
            itemCount: surveyKeys.length,
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildSurveyStat(
      String surveyKey, int surveyDogDetailsProviders, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '∘ $surveyKey',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < surveyDogDetailsProviders
                    ? Icons.star
                    : Icons.star_border,
                color: Colors.amber,
                size: 15,
              );
            }),
          ),
        ],
      ),
    );
  }
}
