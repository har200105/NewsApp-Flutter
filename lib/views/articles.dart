import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class Article extends StatefulWidget {
  final String articleUrl;
  Article({this.articleUrl});
  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {

  final Completer<WebViewController> controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Khabar"),
            Text(
              "Batao",
              style: TextStyle(color: Colors.purple),
            ),
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
                      child: Container(
              padding: EdgeInsets.symmetric(horizontal:16),
              child: Icon(Icons.save)
              ),
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.articleUrl,
          onWebViewCreated: ((WebViewController webViewController){
            controller.complete(webViewController);
          }),
        ),
      ),
    );
  }
}