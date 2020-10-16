import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:puppy_world/models/dogs.dart';
import 'package:http/http.dart' as http;

class HomePageService {
  Future<Dogs> fetchDogsList({
    @required int pageNumber,
    String searchKey = '',
    int pageSize = 20,
  }) async {
    try {
      var url =
          'http://puppyworld.azurewebsites.net/api/v1/profiles/tiles?limit=$pageSize&skip=${pageNumber * pageSize}&searchKey=$searchKey';

      var response = await http.get(url);
      if (response.statusCode == 200) {
        return Dogs.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
