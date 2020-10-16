import 'package:puppy_world/services/explore_api.dart';

import 'dog_tiles_provider.dart';

class DogTilesSearchProvider extends DogTilesProvider {
  String _searchKey;

  String get searchKey {
    return _searchKey;
  }

  bool get isSearching {
    return this.loadingDogListInProgress && this.dogs.length == 0;
  }

  bool get hasSearchKey {
    return _searchKey != null && _searchKey.isNotEmpty;
  }

  bool get hasSearchResult {
    return !this.loadingDogListInProgress &&
        this.dogs.length == 0 &&
        this.hasSearchKey;
  }

  void clearSearch() {
    _searchKey = null;
    dogsProtected.clear();
    notifyListeners();
  }

  Future<void> searchDogs(String searchKey) async {
    this.totalProtected = 0;
    this.dogsProtected = [];
    this.pageNumberProtected = 0;
    this._searchKey = searchKey.trim();
    await fetchDogsList();
  }

  Future fetchDogsList() async {
    try {
      loadingDogListInProgressProtected = true;
      notifyListeners();
      final result = await ExploreApiService.getDogProfileTiles(
        pageNumber: pageNumberProtected,
        searchKey: this._searchKey,
      );
      dogsProtected.addAll(result.items);
      totalProtected = result.total;
    } finally {
      loadingDogListInProgressProtected = false;
      notifyListeners();
    }
  }
}
