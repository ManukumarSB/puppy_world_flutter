import 'package:sprintf/sprintf.dart';

class EndpointUrlProvider {
  static const String apiEndPoint =
      "http://puppyworld.azurewebsites.net/api/v1/";

  static const String _profilePath = "profiles/";
  static const String _tilesPath = "tiles?limit=%d&skip=%d&searchKey=%s";
  static const String _verifyEmailPath = "user/exists/email?email=";
  static const String _loginPath = "login";
  static const String _userPath = "user";
  static const String _feedsPath = "feeds";

  static String getPetTilesUrl(int limit, int skip, String searchKey) =>
      sprintf("$apiEndPoint$_profilePath$_tilesPath", [limit, skip, searchKey]);

  static String getPetProfileUrl(String dogId) =>
      sprintf("$apiEndPoint$_profilePath$dogId", [dogId]);

  static String verifyEmailUrl(String email) =>
      sprintf("$apiEndPoint$_verifyEmailPath$email", [email]);

  static String loginUrl() => "$apiEndPoint$_loginPath";

  static String userUrl() => "$apiEndPoint$_userPath";

  static String feedsUrl() => "$apiEndPoint$_feedsPath";
}
