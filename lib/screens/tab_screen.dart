import 'package:flutter/material.dart';
import 'package:puppy_world/screens/explore_screen.dart';
import 'package:puppy_world/screens/profile_screen.dart';

import 'home_screen.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _index = 1;
  final List<Widget> _children = [
    ExploreScreen(), //Feeds
    HomeScreen(), //Explore
    AccountScreen(), //Adopt
    AccountScreen(), //Store
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
