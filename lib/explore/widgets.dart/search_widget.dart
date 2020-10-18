import 'dart:async';

import 'package:flutter/material.dart';
import 'package:puppy_world/theme/style.dart';

class SearchWidget extends StatefulWidget {
  final bool autofocus;
  final Function(String searchKey) onSearch;
  final String placeholderText;
  SearchWidget({
    this.autofocus = true,
    @required this.onSearch,
    this.placeholderText = 'Search',
  });
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchFieldController = TextEditingController();
  Timer _searchDebounceTimer;

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: underlinedInputFieldTheme(),
      child: TextField(
        controller: _searchFieldController,
        keyboardType: TextInputType.text,
        autocorrect: false,
        autofocus: true,
        style: TextStyle(color: Theme.of(context).canvasColor),
        onChanged: _onSearchKeyChange,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: widget.placeholderText,
          hintStyle: TextStyle(color: Theme.of(context).canvasColor),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.highlight_off,
              color: Theme.of(context).disabledColor,
            ),
            onPressed: _clearAllSearchResult,
          ),
        ),
      ),
    );
  }

  void _onSearchKeyChange(String searchKey) {
    if (_searchDebounceTimer?.isActive ?? false) {
      _searchDebounceTimer.cancel();
    }

    searchKey = searchKey.trim();
    _searchDebounceTimer = Timer(const Duration(milliseconds: 500), () async {
      _callSearch(searchKey);
    });
  }

  void _clearAllSearchResult() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchFieldController.clear());
    _callSearch(null);
  }

  void _callSearch(String searchKey) {
    if (widget.onSearch == null) return;
    widget.onSearch(searchKey);
  }
}
