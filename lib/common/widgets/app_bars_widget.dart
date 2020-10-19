import 'package:flutter/material.dart';

class AppBars {
  static Widget mainAppBar(BuildContext context) {
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
