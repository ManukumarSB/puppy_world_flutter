import 'package:flutter/material.dart';

import '../services/explore_api.dart';
import '../../common/models/pets/models.dart';

class PetTilesProvider with ChangeNotifier {
  @protected
  List<Pet> dogsProtected = [];
  @protected
  int totalProtected = 0;

  List<Pet> get dogs => [...dogsProtected];
  int get total => totalProtected;
  @protected
  bool loadingPetListInProgressProtected = false;
  @protected
  int pageNumberProtected = 0;
  bool get loadingPetListInProgress => loadingPetListInProgressProtected;

  Future<void> loadNextPage() async {
    if (this.loadingPetListInProgressProtected ||
        this.total == this.dogsProtected.length) {
      return;
    }
    pageNumberProtected++;
    await fetchPetsList();
  }

  Future fetchPetsList() async {
    try {
      loadingPetListInProgressProtected = true;
      notifyListeners();
      final result = await ExploreApiService.getPetProfileTiles(
          pageNumber: pageNumberProtected);
      dogsProtected.addAll(result.items);
      totalProtected = result.total;
    } finally {
      loadingPetListInProgressProtected = false;
      notifyListeners();
    }
  }
}
