import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../widgets.dart/breed_characteristic_widget.dart';
import '../../explore/widgets.dart/vital_stats_widget.dart';
import '../../explore/widgets.dart/widgets.dart';
import '../../common/widgets/widgets.dart';
import '../../common/models/models.dart';
import '../../explore/providers.dart/providers.dart';
import '../../theme/style.dart';

class DogDetailsScreen extends StatefulWidget {
  final String id;
  final Dog dog;

  const DogDetailsScreen({this.id, this.dog});

  @override
  _DogDetailsScreenState createState() => _DogDetailsScreenState();
}

class _DogDetailsScreenState extends State<DogDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _initData();
    });
  }

  _initData() async {
    var homePageProvider =
        Provider.of<DogProfileProvider>(context, listen: false);
    await homePageProvider.fetchDogDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DogProfileProvider>(
      builder: (_, DogProfileProvider value, __) {
        if (value.dog == null || value.loadingDogDetailsInProgress)
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
                      SliverAppBarWidget(dogDetailsProvider: value),
                    ];
                  },
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDivider(),
                          DescriptionWidget(dogDetailsProvider: value),
                          _buildDivider(),
                          VitalStatsWidget(dogDetailsProvider: value),
                          _buildDivider(),
                          BreedCharacteristicWidget(dogDetailsProvider: value),
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
