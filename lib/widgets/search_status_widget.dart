import 'package:flutter/material.dart';

class SearchStatusWidget extends StatelessWidget {
  final String message;
  const SearchStatusWidget(this.message);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontSize: 18,
              ),
        ),
      ),
    );
  }
}

class SearchMessages {
  static const START_TYPING = 'Start typing to search';
  static const SEARCHING = 'Searching ...';
  static const NO_CONTACT_FOUND = 'No Search Result 🔭';
}
