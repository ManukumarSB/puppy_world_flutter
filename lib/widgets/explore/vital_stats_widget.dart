import 'package:flutter/material.dart';
import 'package:puppy_world/providers/providers.dart';

class VitalStatsWidget extends StatelessWidget {
  final DogProfileProvider dogDetailsProvider;

  const VitalStatsWidget({this.dogDetailsProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vital Information :',
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildVitalStats(
                'Breed Group',
                dogDetailsProvider.dog?.getVitalBreedGroup,
                'assets/vital_icons/icon-breed-group.png',
                context,
              ),
              _buildVitalStats(
                'Height',
                dogDetailsProvider.dog?.getVitalDogHeight,
                'assets/vital_icons/icon-breed-height.png',
                context,
              ),
              _buildVitalStats(
                'Weight',
                dogDetailsProvider.dog?.getVitalDogWeight,
                'assets/vital_icons/icon-breed-weight.png',
                context,
              ),
              _buildVitalStats(
                'Life Span',
                dogDetailsProvider.dog?.getVitalLifeSpan,
                'assets/vital_icons/icon-breed-lifespan.png',
                context,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVitalStats(String title, String dogDetailsProvider,
      String iconPath, BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            child: Image.asset(iconPath),
          ),
          const SizedBox(height: 5),
          Column(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: 12, color: Theme.of(context).primaryColor),
              ),
              Text(
                dogDetailsProvider ?? '',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              )
            ],
          )
        ],
      ),
    );
  }
}
