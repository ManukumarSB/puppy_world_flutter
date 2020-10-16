import 'package:flutter/material.dart';
import 'package:puppy_world/models/dog.dart';
import 'package:puppy_world/services/home_page_service.dart';

class HomePageProvider with ChangeNotifier {
  List<Dog> _dogs = [];
  int _total = 0;
  HomePageService _homePageService = HomePageService();

  List<Dog> get dogs => [..._dogs];
  int get total => _total;
  bool _loadingDogListInProgress = false;
  int _pageNumber = 0;
  bool get loadingDogListInProgress => _loadingDogListInProgress;

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
      final result =
          await _homePageService.fetchDogsList(pageNumber: _pageNumber);
      _dogs.addAll(result.items);
      _total = result.total;
    } finally {
      _loadingDogListInProgress = false;
      notifyListeners();
    }
  }
}
