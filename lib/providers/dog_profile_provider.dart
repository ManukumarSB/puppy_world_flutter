import 'package:flutter/material.dart';
import 'package:puppy_world/models/dog.dart';
import 'package:puppy_world/services/explore_api.dart';

class DogProfileProvider with ChangeNotifier {
  Dog _dog;
  Dog get dog => _dog;
  bool _loadingDogDetailsInProgress = false;
  bool get loadingDogDetailsInProgress => _loadingDogDetailsInProgress;

  Future fetchDogDetails(String dogId) async {
    try {
      _loadingDogDetailsInProgress = true;
      notifyListeners();
      final result = await ExploreApiService.getDogProfileById(dogId: dogId);
      _dog = result;
    } finally {
      _loadingDogDetailsInProgress = false;
      notifyListeners();
    }
  }
}
