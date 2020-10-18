import 'package:flutter/material.dart';
import 'package:puppy_world/account/screens.dart/account_screen.dart';
import 'package:puppy_world/adopt/screens.dart/adopt_screen.dart';
import 'package:puppy_world/explore/screens.dart/explore_screen.dart';
import 'package:puppy_world/feeds/screens.dart/store_screen.dart';
import 'package:puppy_world/store/screens.dart/store_screen.dart';

class MainTabScreen extends StatefulWidget {
  @override
  _MainTabScreenState createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _index = 1;
  final List<Widget> _children = [
    FeedsScreen(), //Feeds
    ExploreScreen(), //Explore
    AdoptScreen(), //Adopt
    StoreScreen(), //Store
    AccountScreen(), //Account
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _index,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedItemColor: Theme.of(context).primaryColor,
        items: [
          _buildBottomNavBar(Icons.image, 'Feed'),
          _buildBottomNavBar(Icons.explore, 'Explore'),
          _buildBottomNavBar(Icons.feedback, 'Adopt'),
          _buildBottomNavBar(Icons.store, 'Store'),
          _buildBottomNavBar(Icons.account_circle, 'Account'),
        ],
      ),
      body: Center(
        child: (_children[_index]),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  BottomNavigationBarItem _buildBottomNavBar(IconData iconData, String title) {
    return BottomNavigationBarItem(
      icon: Icon(iconData),
      title: Text(title),
    );
  }
}
