import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:puppy_world/models/dog.dart';
import 'package:http/http.dart' as http;

class DogDetailsService {
  Future<Dog> fetchDogDetails({
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
}
