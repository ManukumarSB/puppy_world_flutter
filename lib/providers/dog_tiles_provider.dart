import 'package:flutter/material.dart';
import 'package:puppy_world/models/dog.dart';
import 'package:puppy_world/services/explore_api.dart';

class DogTilesProvider with ChangeNotifier {
  @protected
  List<Dog> dogsProtected = [];
  @protected
  int totalProtected = 0;

  List<Dog> get dogs => [...dogsProtected];
  int get total => totalProtected;
  @protected
  bool loadingDogListInProgressProtected = false;
  @protected
  int pageNumberProtected = 0;
  bool get loadingDogListInProgress => loadingDogListInProgressProtected;

  Future<void> loadNextPage() async {
    if (this.loadingDogListInProgressProtected ||
        this.total == this.dogsProtected.length) {
      return;
    }
    pageNumberProtected++;
    await fetchDogsList();
  }

  Future fetchDogsList() async {
    try {
      loadingDogListInProgressProtected = true;
      notifyListeners();
      final result = await ExploreApiService.getDogProfileTiles(
          pageNumber: pageNumberProtected);
      dogsProtected.addAll(result.items);
      totalProtected = result.total;
    } finally {
      loadingDogListInProgressProtected = false;
      notifyListeners();
    }
  }
}
