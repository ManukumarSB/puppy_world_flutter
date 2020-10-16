import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_page_search_provider.dart';
import '../widgets/dogs_list_widget.dart';
import '../widgets/search_status_widget.dart';
import '../widgets/search_widget.dart';

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
    return Consumer<HomePageSearchProvider>(
      builder: (_, HomePageSearchProvider value, __) {
        if (!value.hasSearchKey) {
          return SearchStatusWidget(SearchMessages.START_TYPING);
        }
        if (value.isSearching) {
          return SearchStatusWidget(SearchMessages.SEARCHING);
        }

        if (value.hasAnyContactFound) {
          return SearchStatusWidget(SearchMessages.NO_CONTACT_FOUND);
        }

        return NotificationListener(
          onNotification: (ScrollNotification scrollNotification) {
            return _onListScroll(scrollNotification, value);
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: DogsListWidget(
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
      Provider.of<HomePageSearchProvider>(context, listen: false).clearSearch();
      return;
    }
    if (searchKey.length > 2) {
      await Provider.of<HomePageSearchProvider>(context, listen: false)
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
