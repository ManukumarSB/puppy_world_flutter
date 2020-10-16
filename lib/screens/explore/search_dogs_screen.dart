import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/dog_tiles_search_provider.dart';
import '../../widgets/explore/dog_tile_widget.dart';
import '../../widgets/search_status_widget.dart';
import '../../widgets/search_widget.dart';

class SearchDogsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildSearchAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildSearchAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Container(
        height: 40,
        child: SearchWidget(
          placeholderText: 'Search dogs by name',
          onSearch: (String searchKey) {
            _onSearch(searchKey, context);
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<DogTilesSearchProvider>(
      builder: (_, DogTilesSearchProvider value, __) {
        if (!value.hasSearchKey) {
          return SearchStatusWidget(SearchMessages.START_TYPING);
        }
        if (value.isSearching) {
          return SearchStatusWidget(SearchMessages.SEARCHING);
        }

        if (value.hasSearchResult) {
          return SearchStatusWidget(SearchMessages.NO_CONTACT_FOUND);
        }

        return NotificationListener(
          onNotification: (ScrollNotification scrollNotification) {
            return _onListScroll(scrollNotification, value);
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: DogTileWidget(
                dogs: value.dogs,
                loadingDogListInProgress: value.loadingDogListInProgress,
                loadNextPage: value.loadNextPage,
                searchKey: value.searchKey,
              ),
            ),
          ),
        );
      },
    );
  }

  _onSearch(String searchKey, BuildContext context) async {
    if (searchKey == null || searchKey.isEmpty) {
      Provider.of<DogTilesSearchProvider>(context, listen: false).clearSearch();
      return;
    }
    if (searchKey.length > 2) {
      await Provider.of<DogTilesSearchProvider>(context, listen: false)
          .searchDogs(searchKey);
    }
  }

  bool _onListScroll(ScrollNotification scrollNotification, value) {
    if (scrollNotification is ScrollEndNotification &&
        scrollNotification.metrics.pixels >=
            scrollNotification.metrics.maxScrollExtent) {
      value.loadNextPage();
    }
    return true;
  }
}
