import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../common/helpers/storage_manager.dart';
import '../../common/models/user/user.dart';
import '../../user_auth/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  StorageManager _tokenManager = StorageManager();
  String _emailAddress;
  bool _verifyNewSupporterEmail = false;
  User _user;
  String get emailAddress {
    return _emailAddress;
  }

  User get user => _user;

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

  Future<User> login(String email, String password) async {
    try {
      final result = await AuthService.login(email: email, password: password);
      var response = jsonDecode(result.result);

      await _tokenManager.setToken(response['token']);
      _user = response['user'];
      return _user;
    } finally {
      notifyListeners();
    }
  }

  Future<User> createUser(
      {@required User user,
      @required String password,
      File profilePicture}) async {
    try {
      final result = await AuthService.createUser(
          user: user, password: password, profilePicture: profilePicture);
      // var response = jsonDecode(result.result);

      // await _tokenManager.setToken(response['token']);
      // _user = response['user'];
      return _user;
    } finally {
      notifyListeners();
    }
  }
}
