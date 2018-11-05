import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:simple_flutter/redux/global_state.dart';

class WebViewPage extends StatefulWidget {
  String title;
  String link;

  WebViewPage(this.title, this.link);

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  final flutterWebViewPlugin = new FlutterWebviewPlugin();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (WebViewState.finishLoad == state.type) {
        setState(() {
          isLoading = false;
        });
      } else if (WebViewState.startLoad == state.type) {
        setState(() {
          isLoading = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        return Container(
          child: WebviewScaffold(
            url: widget.link,
            appBar: AppBar(
              title: Text(widget.title),
              bottom: PreferredSize(
                  child: isLoading ? LinearProgressIndicator() : Container(),
                  preferredSize: Size.fromHeight(1.0)),
            ),
            withZoom: true,
            withJavascript: true,
          ),
        );
      },
    );
  }
}
