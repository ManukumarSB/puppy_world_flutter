import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:puppy_world/models/dog.dart';
import 'package:http/http.dart' as http;
import 'package:puppy_world/models/dogs.dart';
import 'package:puppy_world/services/common_api.dart';

class ExploreApiService {
  static Future<Dog> getDogProfileById({
    @required String id,
  }) async {
    try {
      var url = 'http://puppyworld.azurewebsites.net/api/v1/profiles/$id';

      var response = await http.get(url);
      if (response.statusCode == 200) {
        return Dog.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Dogs> getDogProfileTiles({
    @required int pageNumber,
    String searchKey = '',
    int pageSize = 20,
  }) async {
    try {
      var url = CommonApiService.getDogTilesUrl(
          pageSize, pageNumber * pageSize, searchKey);
      var response = await CommonApiService.getResponse(url, false);
      if (response.success) {
        return Dogs.fromJson(jsonDecode(response.result));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
