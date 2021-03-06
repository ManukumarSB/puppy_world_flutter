import 'package:flutter/material.dart';
import 'package:puppy_world/common/widgets/widgets.dart';

class AdoptScreen extends StatelessWidget {
  const AdoptScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.mainAppBar(context),
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
