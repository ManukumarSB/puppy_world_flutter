import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:puppy_world/common/models/user/user.dart';
import 'package:sprintf/sprintf.dart';

class RequestResponse {
  RequestResponse(this.result, this.success);
  bool success;
  String result;
}

class CommonApiService {
  static const String ApiEndpoint =
      "http://puppyworld.azurewebsites.net/api/v1/";

  static const String _ProfilePath = "profiles/";
  static const String _TilesPath = "tiles?limit=%d&skip=%d&searchKey=%s";
  static const String _verifyEmailPath = "user/exists/email?email=";
  static const String _loginPath = "login";
  static const String _signUpPath = "user";

  static String getPetTilesUrl(int limit, int skip, String searchKey) =>
      sprintf("$ApiEndpoint$_ProfilePath$_TilesPath", [limit, skip, searchKey]);

  static String getPetProfileUrl(String dogId) =>
      sprintf("$ApiEndpoint$_ProfilePath$dogId", [dogId]);
  static String verifyEmail(String email) =>
      sprintf("$ApiEndpoint$_verifyEmailPath$email", [email]);
  static String login() => sprintf("$ApiEndpoint$_loginPath", []);

  static String signUp() => sprintf("$ApiEndpoint$_signUpPath", []);

  static Future<RequestResponse> getResponse(
      String url, bool authRequired) async {
    var response = await http.get(url);
    //  if(authRequired)
    if (response.statusCode == 200) {
      return RequestResponse(response.body, true);
    } else
      return RequestResponse('', false);
  }

  static Future<RequestResponse> postResponse(
      String url, bool authRequired, String email, String password) async {
    var data = jsonEncode({"email": email, "password": password});
    var response = await http.post(
      url,
      body: data,
      headers: {"Content-Type": "application/json"},
    );
    //  if(authRequired)
    if (response.statusCode == 200) {
      return RequestResponse(response.body, true);
    } else if (response.statusCode == 102) {
      return RequestResponse('Wrong Password', false);
    }
    return RequestResponse('', false);
  }

  static Future<RequestResponse> createUser(String url, bool authRequired,
      User user, String password, File profilePicture) async {
    FormData formData = FormData.fromMap({
      "userData": jsonEncode(user),
      "profilePicture": await MultipartFile.fromFile(profilePicture.path,
          filename: 'profile' +
              profilePicture.path
                  .substring(profilePicture.path.lastIndexOf('.'))),
      "password": password
    });
    final response = await Dio().post(url, data: formData);

    //  if(authRequired)
    if (response.statusCode == 200) {
      return RequestResponse(response.data, true);
    } else if (response.statusCode == 102) {
      return RequestResponse('Wrong Password', false);
    }
    return RequestResponse('', false);
  }
}
