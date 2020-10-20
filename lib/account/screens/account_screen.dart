import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../user_auth/screens/screens.dart';
import '../../common/widgets/widgets.dart';
import '../../common/widgets/primary_button_widget.dart';
import '../../user_auth/providers/auth_provider.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = 'tab/account';

  const AccountScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.mainAppBar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              const SizedBox(height: 16),
              PrimaryButtonWidget(false, 'Login', () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return ChangeNotifierProvider(
                      create: (BuildContext context) {
                        return AuthProvider();
                      },
                      child: AuthHomeScreen(),
                    );
                  }),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
