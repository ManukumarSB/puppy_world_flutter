import 'dart:convert';

import 'package:flutter/material.dart';

import '../../common/models/pets/models.dart';
import '../../common/services/common_api.dart';

class ExploreApiService {
  static Future<Pet> getPetProfileById({
    @required String dogId,
  }) async {
    try {
      var url = CommonApiService.getPetProfileUrl(dogId);

      var response = await CommonApiService.getResponse(url, false);
      if (response.success) {
        return Pet.fromJson(jsonDecode(response.result));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Pets> getPetProfileTiles({
    @required int pageNumber,
    String searchKey = '',
    int pageSize = 20,
  }) async {
    try {
      var url = CommonApiService.getPetTilesUrl(
          pageSize, pageNumber * pageSize, searchKey);
      var response = await CommonApiService.getResponse(url, false);
      if (response.success) {
        return Pets.fromJson(jsonDecode(response.result));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
