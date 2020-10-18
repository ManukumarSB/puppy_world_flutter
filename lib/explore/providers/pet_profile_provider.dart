import 'package:flutter/material.dart';

import '../../common/models/pets/models.dart';
import '../../explore/services/explore_api.dart';

class PetProfileProvider with ChangeNotifier {
  Pet _pet;
  Pet get pet => _pet;
  bool _loadingPetDetailsInProgress = false;
  bool get loadingPetDetailsInProgress => _loadingPetDetailsInProgress;

  Future fetchDogDetails(String dogId) async {
    try {
      _loadingPetDetailsInProgress = true;
      notifyListeners();
      final result = await ExploreApiService.getPetProfileById(dogId: dogId);
      _pet = result;
    } finally {
      _loadingPetDetailsInProgress = false;
      notifyListeners();
    }
  }
}
