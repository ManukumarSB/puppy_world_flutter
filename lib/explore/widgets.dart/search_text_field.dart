import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../explore/screens.dart/search_dogs_screen.dart';
import '../../explore/providers.dart/providers.dart';

class SearchTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => DogTilesSearchProvider(),
              child: SearchDogsScreen(),
            ),
          ),
        );
      },
      decoration: InputDecoration(
        hintText: 'Search for Dogs',
        contentPadding: const EdgeInsets.symmetric(
          vertical: 11,
          horizontal: 15,
        ),
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey[400],
        ),
        suffixIcon: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(3),
              bottomRight: Radius.circular(3),
            ),
          ),
          child: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        border: Theme.of(context).inputDecorationTheme.border,
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
        ),
      ),
    );
  }
}
