import 'dart:io';

import 'package:flutter/material.dart';

import '../../common/services/exception_handler.dart';
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
      final result =
          !(await RestApiRequest.get(url, authRequired: false)).success;

      return result;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> login(
      {@required String email, @required String password}) async {
    try {
      var url = EndpointUrlProvider.loginUrl();
      var header = HeaderBuilder().setToJsonType().build();
      dynamic body = {"email": email, "password": password};
      var response = await RestApiRequest.post(url,
          headers: header, body: body, authRequired: false);

      return response.success ? response.result : response.handleException();
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> createUser(
      {@required UserAccount user,
      @required String password,
      File profilePicture}) async {
    try {
      var url = EndpointUrlProvider.userUrl();
      var formData = (await new FormDataBuilder()
              .addFile("profilePicture", profilePicture))
          .addObject("userData", user)
          .addString("password", password)
          .build();

      final response =
          await RestApiRequest.postForm(url, formData, authRequired: false);

      return response.success ? response.result : response.handleException();
    } catch (e) {
      rethrow;
    }
  }
}
