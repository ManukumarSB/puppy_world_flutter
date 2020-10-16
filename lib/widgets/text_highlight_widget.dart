import 'package:flutter/material.dart';

class TextHighlightWidget extends StatelessWidget {
  final String text;
  final String searchKey;
  final TextStyle textStyle;
  TextHighlightWidget(this.text, this.searchKey, this.textStyle);
  @override
  Widget build(BuildContext context) {
    if (searchKey == null || searchKey.isEmpty) {
      return RichText(
        overflow: TextOverflow.ellipsis,
        text: TextSpan(style: textStyle, text: text),
      );
    }

    /// returns highlighted rich text widget with passed text style

    //get all matched items from regex
    // this is required for replacing with proper text (with capitalization)
    var matchedItems =
        RegExp(searchKey ?? '', caseSensitive: false).allMatches(text).toList();

    // create all text spans excluding matched text
    List<TextSpan> textSpans =
        text.split(new RegExp(searchKey, caseSensitive: false)).map((f) {
      return TextSpan(text: f);
    }).toList();

    // copying to new list
    List<TextSpan> finalTextSpan = textSpans.map((f) => f).toList();

    // 'join' with proper matched item to update finalTextSpan
    for (var i = 0; i < textSpans.length - 1; i++) {
      finalTextSpan.insert(
        i + 1,
        TextSpan(
          text: text.substring(matchedItems[i].start, matchedItems[i].end),
          // matched text styling. Currently just makes it bold
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xff6b1b00)),
        ),
      );
    }

    // create richText object and return
    return RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: textStyle,
        children: finalTextSpan,
      ),
    );
  }
}
