import 'package:flutter/material.dart';
import 'package:puppy_world/models/dog.dart';
import 'package:puppy_world/services/home_page_service.dart';

class HomePageSearchProvider with ChangeNotifier {
  List<Dog> _dogs = [];
  int _total = 0;
  HomePageService _homePageService = HomePageService();

  List<Dog> get dogs => [..._dogs];
  int get total => _total;
  bool _loadingDogListInProgress = false;
  int _pageNumber = 0;
  bool get loadingDogListInProgress => _loadingDogListInProgress;

  String _searchKey;

  String get searchKey {
    return _searchKey;
  }

  bool get isSearching {
    return this.loadingDogListInProgress && this.dogs.length == 0;
  }

  bool get hasAnyContactFound {
    return !this.loadingDogListInProgress &&
        this.dogs.length == 0 &&
        this.hasSearchKey;
  }

  bool get hasSearchKey {
    return _searchKey != null && _searchKey.isNotEmpty;
  }

  void clearSearch() {
    _searchKey = null;
    this._dogs.clear();
    notifyListeners();
  }

  Future<void> searchDogs(String searchKey) async {
    this._total = 0;
    this._dogs = [];
    this._pageNumber = 0;
    this._searchKey = searchKey.trim();
    await fetchDogsList();
  }

  Future<void> loadNextPage() async {
    if (this._loadingDogListInProgress || this.total == this._dogs.length) {
      return;
    }
    _pageNumber++;
    await fetchDogsList();
  }

  Future fetchDogsList() async {
    try {
      _loadingDogListInProgress = true;
      notifyListeners();
      final result = await _homePageService.fetchDogsList(
        pageNumber: _pageNumber,
        searchKey: this._searchKey,
      );
      _dogs.addAll(result.items);
      _total = result.total;
    } finally {
      _loadingDogListInProgress = false;
      notifyListeners();
    }
  }
}
