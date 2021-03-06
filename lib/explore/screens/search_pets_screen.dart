import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class SearchPetsScreen extends StatelessWidget {
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
    return Consumer<PetTilesSearchProvider>(
      builder: (_, PetTilesSearchProvider value, __) {
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
              child: PetTileWidget(
                pets: value.dogs,
                loadingPetListInProgress: value.loadingPetListInProgress,
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
      Provider.of<PetTilesSearchProvider>(context, listen: false).clearSearch();
      return;
    }
    if (searchKey.length > 2) {
      await Provider.of<PetTilesSearchProvider>(context, listen: false)
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
