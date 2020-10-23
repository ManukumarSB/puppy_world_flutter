import 'package:sprintf/sprintf.dart';

class EndpointUrlProvider {
  static const String apiEndPoint =
      "http://puppyworld.azurewebsites.net/api/v1/";

//Explore

  static const String _profilePath = "profiles/";
  static const String _tilesPath = "tiles?limit=%d&skip=%d&searchKey=%s";

  static String getPetTilesUrl(int limit, int skip, String searchKey) =>
      sprintf("$apiEndPoint$_profilePath$_tilesPath", [limit, skip, searchKey]);

  static String getPetProfileUrl(String dogId) =>
      sprintf("$apiEndPoint$_profilePath$dogId", [dogId]);

  //Account

  static const String _verifyEmailPath = "user/exists/email?email=";
  static const String _loginPath = "login";
  static const String _userPath = "user";

  static String verifyEmailUrl(String email) =>
      sprintf("$apiEndPoint$_verifyEmailPath$email", [email]);

  static String loginUrl() => "$apiEndPoint$_loginPath";

  static String userUrl() => "$apiEndPoint$_userPath";

  static String feedsUrl() => "$apiEndPoint$_feedsPath";

//Feeds

  static const String _feedsPath = "feeds";
  static const String _userFeedsPath = "feeds/user?userId=%s&limit=%d&skip=%d";
  static const String _feedLikesPath = "feeds/likes?feedId=%s&limit=%d&skip=%d";
  static const String _feedCommentsPath =
      "feeds/comments?feedId=%s&limit=%d&skip=%d";

  static String getFeedByIdUrl(String feedId) =>
      "$apiEndPoint$_feedsPath/$feedId";

  static String getUserFeedsUrl(String userId, int limit, int skip) =>
      sprintf("$apiEndPoint$_userFeedsPath", [userId, limit, skip]);

  static String getFeedLikesUrl(String feedId, int limit, int skip) =>
      sprintf("$apiEndPoint$_feedLikesPath", [feedId, limit, skip]);

  static String getFeedCommentsUrl(String feedId, int limit, int skip) =>
      sprintf("$apiEndPoint$_feedCommentsPath", [feedId, limit, skip]);
}
