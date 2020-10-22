import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as Http;
import '../exceptions/custom_exceptions.dart';
import '../../common/helpers/response_codes.dart';
import '../../common/helpers/storage_manager.dart';

class RestApiBadResponse {
  int code;
  String message;
  RestApiBadResponse(this.code, this.message);

  String getAppErrorMessage() => ResponseCodesHelper.getMessage(code);
}

class RestApiResponse {
  bool success;
  dynamic result;
  RestApiResponse(this.success, this.result);

  RestApiBadResponse getBadResponseObject() {
    return success
        ? null
        : RestApiBadResponse(result["code"], result["message"]);
  }
}

class RestApiRequest {
  static const String authorizationKey = "Authorization";

  static Future<String> _getLoginToken() async {
    var token = await StorageManager.getAuthToken();
    return token?.isEmpty ?? true ? throw UserAuthException(null) : token;
  }

  static RestApiResponse _createResponse(int statusCode, dynamic data) {
    switch (statusCode) {
      case 200:
        return RestApiResponse(true, data);
        break;
      case 400:
        return RestApiResponse(false, data);
        break;
      case 403:
        throw UserAuthException(null);
        break;
      default:
        throw UnexpectedServerError(null);
    }
  }

  static Future<RestApiResponse> get(String url,
      {@optionalTypeArgs Map<String, String> headers,
      @optionalTypeArgs bool authRequired = true}) async {
    try {
      if (headers == null) headers = Map<String, String>();
      if (authRequired) headers[authorizationKey] = await _getLoginToken();
      var response = await Http.get(url, headers: headers);
      return _createResponse(response.statusCode, jsonDecode(response.body));
    } on SocketException {
      throw NoInternetConnection(null);
    } catch (e) {
      throw e;
    }
  }

  static Future<RestApiResponse> post(String url,
      {@optionalTypeArgs Map<String, String> headers,
      @optionalTypeArgs dynamic body,
      @optionalTypeArgs bool authRequired = true}) async {
    try {
      if (headers == null) headers = Map<String, String>();
      if (authRequired) headers[authorizationKey] = await _getLoginToken();
      var response = await Http.post(url, body: body, headers: headers);
      return _createResponse(response.statusCode, jsonDecode(response.body));
    } on SocketException {
      throw NoInternetConnection(null);
    } catch (e) {
      throw e;
    }
  }

  static Future<RestApiResponse> postForm(String url, FormData formData,
      {@optionalTypeArgs bool authRequired = true}) async {
    try {
      Options options;
      if (authRequired) {
        options = Options(headers: {authorizationKey: await _getLoginToken()});
      }
      var response = await Dio().post(url, data: formData, options: options);
      return _createResponse(response.statusCode, response.data);
    } on SocketException {
      throw NoInternetConnection(null);
    } on DioError catch (e) {
      return _createResponse(e.response.statusCode, e.response.data);
    } catch (e) {
      throw e;
    }
  }
}
