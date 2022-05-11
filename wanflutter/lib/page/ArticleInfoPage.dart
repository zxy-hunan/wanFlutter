import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ArticleInfoPage extends StatelessWidget {
  String url, title;

  ArticleInfoPage({Key? key, required this.title, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Theme.of(context).primaryColor),
      routes: {
        "/": (_) => WebviewScaffold(
              url: this.url,
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
                title: Text(this.title),
                actions: [
                  IconButton(
                      onPressed: () {
                        print("object");
                      },
                      icon: Icon(Icons.share),
                      tooltip: '分享')
                ],
              ),
            )
      },
    );
  }
}
