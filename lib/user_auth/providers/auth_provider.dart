import 'dart:convert';
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

  bool get verifyNewSupporterEmail {
    return _verifyNewSupporterEmail;
  }

  void setEmailAddress(String email) {
    _emailAddress = email;
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
      final result = await AuthService.login(email: email, password: password);
      if (result.success) {
        await StorageManager.setAuthToken(result.result['token'] as String);
        var _user = result.result['user'];
        return _user;
      }
      return null;
    } finally {
      notifyListeners();
    }
  }

  Future<UserAccount> createUser(
      {@required UserAccount user,
      @required String password,
      File profilePicture}) async {
    try {
      final result = await AuthService.createUser(
          user: user, password: password, profilePicture: profilePicture);
      if (result.success) {
        await StorageManager.setAuthToken(result.result['token']);
        return UserAccount.fromJson(result.result["user"]);
      }
      return null;
    } finally {
      notifyListeners();
    }
  }
}
