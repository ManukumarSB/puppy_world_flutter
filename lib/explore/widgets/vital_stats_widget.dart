import 'package:flutter/material.dart';

import '../../explore/providers/providers.dart';

class VitalStatsWidget extends StatelessWidget {
  final PetProfileProvider petDetailsProvider;

  const VitalStatsWidget({this.petDetailsProvider});

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
                petDetailsProvider.pet?.getVitalBreedGroup,
                'assets/vital_icons/icon-breed-group.png',
                context,
              ),
              _buildVitalStats(
                'Height',
                petDetailsProvider.pet?.getVitalPetHeight,
                'assets/vital_icons/icon-breed-height.png',
                context,
              ),
              _buildVitalStats(
                'Weight',
                petDetailsProvider.pet?.getVitalPetWeight,
                'assets/vital_icons/icon-breed-weight.png',
                context,
              ),
              _buildVitalStats(
                'Life Span',
                petDetailsProvider.pet?.getVitalLifeSpan,
                'assets/vital_icons/icon-breed-lifespan.png',
                context,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVitalStats(String title, String petDetailsProvider,
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
                petDetailsProvider ?? '',
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
