import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/widgets.dart';
import '../../explore/screens.dart/dog_details_screen.dart';
import '../../common/models/models.dart';
import '../../explore/providers.dart/providers.dart';

class DogTileWidget extends StatelessWidget {
  final List<Dog> dogs;

  final bool loadingDogListInProgress;
  final Function loadNextPage;
  final String searchKey;

  const DogTileWidget(
      {Key key,
      this.dogs,
      this.loadingDogListInProgress,
      this.loadNextPage,
      this.searchKey});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        if (index == dogs.length - 1 && loadingDogListInProgress) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: TileLoadingSkeletonWidget());
        }
        if (index < dogs.length) {
          return _buildDogCard(dogs[index], context);
        }
        return const SizedBox(
          height: 20,
        );
      },
      itemCount: dogs.length,
    );
  }

  Widget _buildDogCard(Dog dog, BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => DogProfileProvider(),
              child: DogDetailsScreen(id: dog.id, dog: dog),
            ),
          ),
        );
      },
      child: Container(
        height: 110 + 12 * textScaleFactor,
        margin: const EdgeInsets.only(bottom: 8),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            side: new BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Row(
            children: <Widget>[
              _buildDogImage(dog, context),
              _buildDogDetails(dog, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDogDetails(Dog dog, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 12, bottom: 5, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: TextHighlightWidget(
                    dog.name,
                    searchKey,
                    Theme.of(context).textTheme.subtitle2.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 5),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: _buildVitalStats(
                              'Breed Group',
                              dog.getVitalBreedGroup,
                              'assets/vital_icons/icon-breed-group.png',
                              context),
                        ),
                        Expanded(
                          flex: 1,
                          child: _buildVitalStats(
                              'Life Span',
                              dog.getVitalLifeSpan,
                              'assets/vital_icons/icon-breed-lifespan.png',
                              context),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDogImage(Dog dog, BuildContext context) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.only(topLeft: const Radius.circular(5)),
        color: Color(0xfff1f1f1),
      ),
      child: CachedNetworkImage(
        imageUrl: dog.profileImageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVitalStats(
      String title, String value, String iconPath, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 30,
          child: Image.asset(iconPath),
        ),
        const SizedBox(height: 2),
        Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  fontSize: 12, color: Theme.of(context).primaryColor),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            )
          ],
        )
      ],
    );
  }
}
