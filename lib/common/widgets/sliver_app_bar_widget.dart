import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

import '../../explore/providers.dart/providers.dart';
import '../../theme/style.dart';

class SliverAppBarWidget extends StatelessWidget {
  final DogProfileProvider dogDetailsProvider;
  const SliverAppBarWidget({this.dogDetailsProvider});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      backgroundColor: Theme.of(context).primaryColor,
      floating: false,
      pinned: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return FlexibleSpaceBar(
          centerTitle: true,
          title: Container(
            padding: const EdgeInsets.only(
              left: 16,
            ),
            width: MediaQuery.of(context).size.width * .7,
            child: Text(
              dogDetailsProvider.dog?.name ?? '',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          background: Container(
            color: CustomThemeData.ocPrimaryTextColor,
            child: Carousel(
              autoplay: false,
              dotSpacing: 20.0,
              dotSize: 5,
              dotColor: Colors.grey,
              indicatorBgPadding: 10.0,
              images: dogDetailsProvider.dog?.getDogImages,
              borderRadius: true,
            ),
          ),
        );
      }),
    );
  }
}
