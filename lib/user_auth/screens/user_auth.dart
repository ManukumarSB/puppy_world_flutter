import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puppy_world/user_auth/screens/screens.dart';

import '../../user_auth/providers/auth_provider.dart';

import 'auth_home_screen.dart';

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
            : AuthHomeScreen.routeName,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case AuthHomeScreen.routeName:
              builder = (_) => AuthHomeScreen();
              break;
            case SignUpScreen.routeName:
              builder = (_) => SignUpScreen();
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
