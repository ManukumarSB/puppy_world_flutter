import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = 'tabs/user/account';
  const AccountScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffb3f00),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                'assets/images/coming_soon.png',
                width: 120,
                height: 120,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Coming soon...",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
