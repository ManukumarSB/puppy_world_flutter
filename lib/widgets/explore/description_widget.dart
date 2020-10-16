import 'package:flutter/material.dart';
import 'package:puppy_world/providers/providers.dart';

class DescriptionWidget extends StatelessWidget {
  final DogProfileProvider dogDetailsProvider;
  const DescriptionWidget({Key key, this.dogDetailsProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> texts = [];
    dogDetailsProvider.dog?.description?.forEach(
      (des) => texts.add(
        Text(
          '$des\n',
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description :',
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
            // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: texts,
            ),
          ),
        ],
      ),
    );
  }
}
