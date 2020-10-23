import 'package:flutter/material.dart';

import '../../common/services/rest_api_request.dart';
import '../../common/models/pets/models.dart';
import '../../common/helpers/list_response.dart';
import '../../common/providers/endpoint_url_provider.dart';

class ExploreApiService {
  static Future<Pet> getPetProfileById({
    @required String dogId,
  }) async {
    try {
      var url = EndpointUrlProvider.getPetProfileUrl(dogId);
      var response = await RestApiRequest.get(url, authRequired: false);
      if (response.success) {
        return Pet.fromJson(response.result);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ResponseList<Pet>> getPetProfileTiles({
    @required int pageNumber,
    String searchKey = '',
    int pageSize = 20,
  }) async {
    try {
      var url = EndpointUrlProvider.getPetTilesUrl(
          pageSize, pageNumber * pageSize, searchKey);
      var response = await RestApiRequest.get(url, authRequired: false);
      if (response.success) {
        return ResponseList.fromJson(response.result);
      }
      //TODO:
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
