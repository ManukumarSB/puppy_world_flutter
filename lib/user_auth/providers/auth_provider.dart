import 'dart:io';

import 'package:flutter/material.dart';

import '../../common/helpers/storage_manager.dart';
import '../../common/models/user/user_account.dart';
import '../../user_auth/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  String _emailAddress;
  bool _verifyNewSupporterEmail = false;
  UserAccount _user;
  String get emailAddress {
    return _emailAddress;
  }

  UserAccount get user => _user;
  set setUser(UserAccount userAccount) {
    _user = userAccount;
    notifyListeners();
  }

  bool get verifyNewSupporterEmail {
    return _verifyNewSupporterEmail;
  }

  void setEmailAddress(String email) {
    _emailAddress = email;
  }

  Future<bool> get getUserToken async {
    final token = await StorageManager.getAuthToken();
    return token == null ? false : true;
  }

  Future<void> verifyEmail(String email) async {
    try {
      final result = await AuthService.verifyEmail(email: email);
      _verifyNewSupporterEmail = result;
    } finally {
      notifyListeners();
    }
  }

  Future<UserAccount> login(String email, String password) async {
    try {
      final response =
          await AuthService.login(email: email, password: password);
      await StorageManager.setAuthToken(response['token'] as String);
      _user = UserAccount.fromJson(response['user']);
      return _user;
    } finally {
      notifyListeners();
    }
  }

  Future<UserAccount> createUser(
      {@required UserAccount user,
      @required String password,
      File profilePicture}) async {
    try {
      final response = await AuthService.createUser(
          user: user, password: password, profilePicture: profilePicture);
      await StorageManager.setAuthToken(response['token']);
      _user = UserAccount.fromJson(response["user"]);
      return _user;
    } finally {
      notifyListeners();
    }
  }
}
