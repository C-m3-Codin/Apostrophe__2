import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WeviewPage extends StatefulWidget {
  String url;
  WeviewPage({Key? key, required this.url}) : super(key: key);

  @override
  State<WeviewPage> createState() => _WeviewPageState();
}

class _WeviewPageState extends State<WeviewPage> {
  late WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
        ),
      ),
    );
  }
}
