import 'package:flutter/material.dart';
import 'package:puppy_world/models/dog.dart';
import 'package:puppy_world/services/dog_details_service.dart';

class DogDetailsProvider with ChangeNotifier {
  Dog _dog;
  DogDetailsService _homePageService = DogDetailsService();

  Dog get dog => _dog;
  bool _loadingDogDetailsInProgress = false;
  bool get loadingDogDetailsInProgress => _loadingDogDetailsInProgress;

  Future fetchDogDetails(String dogId) async {
    try {
      _loadingDogDetailsInProgress = true;
      notifyListeners();
      final result = await _homePageService.fetchDogDetails(id: dogId);
      _dog = result;
    } finally {
      _loadingDogDetailsInProgress = false;
      notifyListeners();
    }
  }
}
