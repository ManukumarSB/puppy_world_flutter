import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puppy_world/providers/home_page_provider.dart';
import 'package:puppy_world/screens/tab_screen.dart';
import 'package:puppy_world/theme/style.dart';

void main() {
  runApp(PuppyWorld());
}

class PuppyWorld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => HomePageProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Puppy World',
        theme: appTheme(),
        home: TabScreen(),
      ),
    );
  }
}
