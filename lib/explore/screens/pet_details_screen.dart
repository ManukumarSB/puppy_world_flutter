import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../common/models/pets/models.dart';
import '../../common/widgets/widgets.dart';
import '../../explore/providers/providers.dart';
import '../../explore/widgets/breed_characteristic_widget.dart';
import '../../explore/widgets/vital_stats_widget.dart';
import '../../explore/widgets/widgets.dart';
import '../../theme/style.dart';

class PetDetailsScreen extends StatefulWidget {
  final String id;
  final Pet pet;

  const PetDetailsScreen({this.id, this.pet});

  @override
  _PetDetailsScreenState createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _initData();
    });
  }

  _initData() async {
    var homePageProvider =
        Provider.of<PetProfileProvider>(context, listen: false);
    await homePageProvider.fetchDogDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PetProfileProvider>(
      builder: (_, PetProfileProvider value, __) {
        if (value.pet == null || value.loadingPetDetailsInProgress)
          return _buildSkeletonLoader();
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Scaffold(
              backgroundColor: CustomThemeData.pageBgColor,
              body: SafeArea(
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBarWidget(petDetailsProvider: value),
                    ];
                  },
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDivider(),
                          DescriptionWidget(petDetailsProvider: value),
                          _buildDivider(),
                          VitalStatsWidget(petDetailsProvider: value),
                          _buildDivider(),
                          BreedCharacteristicWidget(petDetailsProvider: value),
                          _buildDivider(),
                          _buildDivider(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkeletonLoader() {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: TileLoadingSkeletonWidget(),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const SizedBox(height: 16);
  }
}
