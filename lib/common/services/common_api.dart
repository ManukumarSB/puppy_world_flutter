import 'package:http/http.dart' as http;
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

  static String getPetTilesUrl(int limit, int skip, String searchKey) =>
      sprintf("$ApiEndpoint$_ProfilePath$_TilesPath", [limit, skip, searchKey]);

  static String getPetProfileUrl(String dogId) =>
      sprintf("$ApiEndpoint$_ProfilePath$dogId", [dogId]);

  static Future<RequestResponse> getResponse(
      String url, bool authRequired) async {
    var response = await http.get(url);
    //  if(authRequired)
    if (response.statusCode == 200) {
      return RequestResponse(response.body, true);
    } else
      return RequestResponse('', false);
  }
}
