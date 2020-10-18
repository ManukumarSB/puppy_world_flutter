import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './theme/style.dart';
import './common/screens/main_tab_screen.dart';
import './explore/providers.dart/providers.dart';

void main() async {
  runApp(PuppyWorld());
}

class PuppyWorld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => DogTilesProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Puppy World',
        theme: appTheme(),
        home: MainTabScreen(),
      ),
    );
  }
}
