import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_page_provider.dart';
import '../widgets/dogs_list_widget.dart';
import '../widgets/search_text_field.dart';
import '../widgets/tile_loading_skeleton_widget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'tabs/user/home';

  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _initData();
    });
  }

  _initData() async {
    var homePageProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    if (homePageProvider.dogs.isEmpty) {
      await homePageProvider.fetchDogsList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Consumer<HomePageProvider>(
          builder: (_, HomePageProvider value, __) {
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
      ScrollNotification scrollNotification, HomePageProvider value) {
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

  Widget _buildSliverList(HomePageProvider value) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return (value.loadingDogListInProgress && value.total == 0)
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: TileLoadingSkeletonWidget(),
                )
              : DogsListWidget(
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
