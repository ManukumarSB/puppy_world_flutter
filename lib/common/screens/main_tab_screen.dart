import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import '../../user_auth/screens/user_auth.dart';
import '../../adopt/screens/adopt_screen.dart';
import '../../explore/screens/explore_screen.dart';
import '../../feeds/screens/store_screen.dart';
import '../../store/screens/store_screen.dart';

class MainTabScreenNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabKey;
  const MainTabScreenNavigator({Key key, this.navigatorKey, this.tabKey})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget child = _MainTabScreenState.tabs
        .firstWhere((element) => element.tabKey == tabKey, orElse: () => null)
        .widget;
    return Navigator(
        key: navigatorKey,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(builder: (context) => child);
        });
  }
}

class TabItem {
  static const String feedTabKey = "feed";
  static const String exploreTabKey = "explore";
  static const String adoptTabKey = "adopt";
  static const String storeTabKey = "store";
  static const String accountTabKey = "account";

  int order; //Screen tab order, from left to right
  String tabKey; //Screen key
  String label; //Display label
  IconData icon; //Icon
  Widget widget; //Screen widget
  GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>(); //Screen widget
  TabItem(this.order, this.tabKey, this.label, this.icon, this.widget);
}

class MainTabScreen extends StatefulWidget {
  @override
  _MainTabScreenState createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  static const int defaultTabIndex = 1;

  int _selectedIndex = defaultTabIndex;
  String _currentTab = tabs[defaultTabIndex].tabKey;

  static final List<TabItem> tabs = _defineTabItems();

  static List<TabItem> _defineTabItems() {
    var tabs = [
      TabItem(1, TabItem.feedTabKey, "Feed", Icons.image, FeedsScreen()),
      TabItem(
          2, TabItem.exploreTabKey, "Explore", Icons.explore, ExploreScreen()),
      TabItem(3, TabItem.adoptTabKey, "Adopt", Icons.favorite, AdoptScreen()),
      TabItem(4, TabItem.storeTabKey, "Store", Icons.shopping_basket,
          StoreScreen()),
      TabItem(5, TabItem.accountTabKey, "Account", Icons.account_circle,
          UserAuth()),
    ];
    tabs.sort((x, y) => x.order.compareTo(y.order)); //Sort based on order
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var isFirstRouteInTheCurrentTab =
            !await tabs[_selectedIndex].navigationKey.currentState.maybePop();
        if (isFirstRouteInTheCurrentTab) {
          if (_currentTab != tabs[defaultTabIndex].tabKey) {
            onTabTap(defaultTabIndex);
            return false;
          }
        }
        return isFirstRouteInTheCurrentTab;
      },
      child: Scaffold(
          body: Stack(
            children: tabs
                .map((e) => Offstage(
                    offstage: _currentTab != e.tabKey,
                    child: MainTabScreenNavigator(
                        navigatorKey: e.navigationKey, tabKey: e.tabKey)))
                .toList(),
          ),
          bottomNavigationBar: BottomNavyBar(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            onItemSelected: onTabTap,
            curve: Curves.decelerate,
            iconSize: 30,
            itemCornerRadius: 5,
            // backgroundColor: Colors.orange[50],
            showElevation: true,
            //backgroundColor: Theme.of(context).primaryColor,
            selectedIndex: _selectedIndex,
            items: tabs
                .map((e) => BottomNavyBarItem(
                    icon: Icon(e.icon),
                    title: Text(e.label),
                    textAlign: TextAlign.center,
                    inactiveColor: Colors.grey,
                    activeColor: Theme.of(context).primaryColor))
                .toList(),
          )),
    );
  }

  void onTabTap(int newIndex) {
    setState(() {
      var newTab = tabs[newIndex];
      if (_currentTab == newTab.tabKey) {
        newTab.navigationKey.currentState.popUntil((route) => route.isFirst);
      } else {
        _currentTab = newTab.tabKey;
        _selectedIndex = newIndex;
      }
    });
  }
}
