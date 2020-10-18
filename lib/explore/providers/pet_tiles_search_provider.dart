import '../services/explore_api.dart';
import 'pet_tiles_provider.dart';

class PetTilesSearchProvider extends PetTilesProvider {
  String _searchKey;

  String get searchKey {
    return _searchKey;
  }

  bool get isSearching {
    return this.loadingPetListInProgress && this.dogs.length == 0;
  }

  bool get hasSearchKey {
    return _searchKey != null && _searchKey.isNotEmpty;
  }

  bool get hasSearchResult {
    return !this.loadingPetListInProgress &&
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

  @override
  Future fetchDogsList() async {
    try {
      loadingPetListInProgressProtected = true;
      notifyListeners();
      final result = await ExploreApiService.getPetProfileTiles(
        pageNumber: pageNumberProtected,
        searchKey: this._searchKey,
      );
      dogsProtected.addAll(result.items);
      totalProtected = result.total;
    } finally {
      loadingPetListInProgressProtected = false;
      notifyListeners();
    }
  }
}
