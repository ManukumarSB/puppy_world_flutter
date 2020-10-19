import 'dart:io';

import 'package:flutter/material.dart';
import '../../common/models/user/user.dart';

import '../../common/services/common_api.dart';

class AuthService {
  static Future<bool> verifyEmail({
    @required String email,
  }) async {
    try {
      var url = CommonApiService.verifyEmail(email);

      var response = await CommonApiService.getResponse(url, false);
      if (response.success) {
        return false;
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  static Future<RequestResponse> login(
      {@required String email, @required String password}) async {
    try {
      var url = CommonApiService.login();

      var response =
          await CommonApiService.postResponse(url, false, email, password);
      if (response.success) {
        return response;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<RequestResponse> createUser(
      {@required User user,
      @required String password,
      File profilePicture}) async {
    try {
      var url = CommonApiService.signUp();
      var response = await CommonApiService.createUser(
          url, false, user, password, profilePicture);

      if (response.success) {
        return response;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
