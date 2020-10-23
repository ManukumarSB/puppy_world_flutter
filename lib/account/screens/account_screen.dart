import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/helpers/storage_manager.dart';
import '../../theme/style.dart';
import '../../user_auth/screens/screens.dart';
import '../../common/widgets/widgets.dart';
import '../../user_auth/providers/auth_provider.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = 'tab/account';

  const AccountScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.mainAppBar(context),
      body: Center(
        child: Consumer<AuthProvider>(
          builder: (_, AuthProvider value, __) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                _buildUserProfile(context, value),
                _buildSectionDivider(context),
                _buildContactSupport(context),
                _buildDivider(),
                _buildNotificationTile(context),
                _buildSectionDivider(context),
                _buildTermsAndPrivacy(context),
                _buildDivider(),
                _buildLogout(context, value),
                _buildShowVersion(),
              ],
            );
          },
        ),
      ),
    );
  }

  ListTile _buildContactSupport(BuildContext context) {
    return ListTile(
      title: Text(
        'Contact Support',
        style: Theme.of(context)
            .textTheme
            .subtitle1
            .copyWith(fontWeight: FontWeight.bold),
      ),
      onTap: () async {},
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: const Divider(
        indent: 20,
      ),
    );
  }

  ListTile _buildTermsAndPrivacy(BuildContext context) {
    return ListTile(
      title: Text(
        'Terms and Privacy',
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              color: Theme.of(context).hintColor,
              fontWeight: FontWeight.bold,
            ),
      ),
      onTap: () async {},
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }

  Widget _buildShowVersion() {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 60),
      alignment: Alignment.center,
      child: Opacity(
        opacity: 0.5,
        child: Text(
          'version 1.0',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionDivider(BuildContext context) {
    return Container(
      height: 30,
      color: CustomThemeData.pageBgColor,
    );
  }

  Widget _buildUserImage(BuildContext context, String profileImage) {
    return Container(
      width: 80.0,
      height: 80.0,
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: Image.network(
            profileImage ??
                'https://p7.hiclipart.com/preview/442/477/305/computer-icons-user-profile-avatar-profile.jpg',
          ).image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, AuthProvider authProvider) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          _buildUserImage(
              context, authProvider?.user?.userDetails?.profileImage),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FutureBuilder<bool>(
                  future: authProvider.getUserToken,
                  builder: (context, snapshot) {
                    return snapshot.data == true && authProvider?.user != null
                        ? Text(
                            authProvider?.user?.name ?? '',
                            style: Theme.of(context).textTheme.headline6,
                          )
                        : InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return ChangeNotifierProvider.value(
                                  value: AuthProvider(),
                                  child: AuthHomeScreen(),
                                );
                              }),
                            ),
                            child: Text(
                              'Log in',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: Colors.blue),
                            ),
                          );
                  },
                ),
                Text(
                  authProvider?.user?.email ?? '',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildLogout(BuildContext context, AuthProvider authProvider) {
    return ListTile(
      title: Text(
        'Log out',
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              color: Theme.of(context).hintColor,
              fontWeight: FontWeight.bold,
            ),
      ),
      onTap: () async {
        StorageManager.clear();
        authProvider.setUser = null;
      },
    );
  }

  Widget _buildNotificationTile(BuildContext context) {
    return SwitchListTile(
      title: Text(
        "Email Notifications",
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "On",
        style: TextStyle(
          color: Colors.grey[700],
        ),
      ),
      value: true,
      onChanged: (val) {},
    );
  }
}
