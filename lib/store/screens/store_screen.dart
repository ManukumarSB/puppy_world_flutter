import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../common/widgets/widgets.dart';

class StoreScreen extends StatelessWidget {
  StoreScreen({Key key}) : super(key: key);

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.mainAppBar(context),
      body: Center(
        child: WebView(
          initialUrl: "https://dukaan.dotpe.in/puppyworld",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (_) {
            _controller.complete(_);
          },
        ),
      ),
      floatingActionButton: FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (cxt, ctrlr) {
          return FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () async {
              await ctrlr.data.loadUrl("https://dukaan.dotpe.in/puppyworld");
            },
          );
        },
      ),
    );
  }
}
