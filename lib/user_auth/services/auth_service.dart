import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../../common/helpers/rest_requests_builder.dart';
import '../../common/services/rest_api_request.dart';
import '../../common/models/user/user_account.dart';

import '../../common/providers/endpoint_url_provider.dart';

class AuthService {
  static Future<bool> verifyEmail({
    @required String email,
  }) async {
    try {
      var url = EndpointUrlProvider.verifyEmailUrl(email);
      return !(await RestApiRequest.get(url, authRequired: false)).success;
    } catch (e) {
      rethrow;
    }
  }

  static Future<RestApiResponse> login(
      {@required String email, @required String password}) async {
    try {
      var url = EndpointUrlProvider.loginUrl();
      var header = HeaderBuilder().setToJsonType().build();
      dynamic body = {"email": email, "password": password};
      var response = await RestApiRequest.post(url,
          headers: header, body: body, authRequired: false);
      if (response.success) {
        return response;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<RestApiResponse> createUser(
      {@required UserAccount user,
      @required String password,
      File profilePicture}) async {
    try {
      var url = EndpointUrlProvider.userUrl();
      var formData = (await new FormDataBuilder()
              .addFile("profilePicture", profilePicture))
          .addText("userData", user)
          .addText("password", password)
          .build();
      return await RestApiRequest.postForm(url, formData, authRequired: false);
    } catch (e) {
      rethrow;
    }
  }
}
