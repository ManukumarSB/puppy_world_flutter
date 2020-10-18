import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/widgets.dart';
import '../../explore/widgets.dart/widgets.dart';
import '../../explore/providers.dart/providers.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with AutomaticKeepAliveClientMixin<ExploreScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _initData();
    });
  }

  @override
  bool get wantKeepAlive => true;

  _initData() async {
    var homePageProvider =
        Provider.of<DogTilesProvider>(context, listen: false);
    if (homePageProvider.dogs.isEmpty) {
      await homePageProvider.fetchDogsList();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Consumer<DogTilesProvider>(
          builder: (_, DogTilesProvider value, __) {
            return NotificationListener(
              onNotification: (ScrollNotification scrollNotification) {
                return _onListScroll(scrollNotification, value);
              },
              child: CustomScrollView(
                slivers: <Widget>[
                  _buildSliverAppBar(),
                  _buildSliverList(value),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  bool _onListScroll(
      ScrollNotification scrollNotification, DogTilesProvider value) {
    if (scrollNotification is ScrollEndNotification &&
        scrollNotification.metrics.pixels >=
            scrollNotification.metrics.maxScrollExtent) {
      value.loadNextPage();
    }
    return true;
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Theme.of(context).canvasColor,
      floating: true,
      elevation: 0.6,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: Column(
          children: <Widget>[
            SearchTextField(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverList(DogTilesProvider value) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return (value.loadingDogListInProgress && value.total == 0)
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: TileLoadingSkeletonWidget(),
                )
              : DogTileWidget(
                  dogs: value.dogs,
                  loadingDogListInProgress: value.loadingDogListInProgress,
                  loadNextPage: value.loadNextPage,
                );
        },
        childCount: 1,
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/puppy_logo.png'),
                fit: BoxFit.fill,
                alignment: Alignment.centerRight,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Puppy World',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
