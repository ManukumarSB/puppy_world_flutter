import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../account/screens/account_screen.dart';
import '../../user_auth/screens/screens.dart';
import '../../user_auth/providers/auth_provider.dart';
import './auth_home_screen.dart';

class UserAuth extends StatelessWidget {
  static const routeName = '/user-auth';
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final authProvider = AuthProvider();

    return ChangeNotifierProvider(
      create: (_) => authProvider,
      child: Navigator(
        initialRoute: arguments != null
            ? arguments['routeName']
            : AccountScreen.routeName,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case AccountScreen.routeName:
              builder = (_) => AccountScreen();
              break;
            case AuthHomeScreen.routeName:
              builder = (_) => AuthHomeScreen();
              break;
            case SignUpScreen.routeName:
              builder = (_) => SignUpScreen(
                    onBack: () {
                      Navigator.of(context).pop();
                    },
                  );
              break;

            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }
}
