import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puppy_world/providers/dog_tiles_provider.dart';
import 'package:puppy_world/screens/main_tab_screen.dart';
import 'package:puppy_world/theme/style.dart';

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
