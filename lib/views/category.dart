import 'package:flutter/material.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/models/ArticleModel.dart';

import 'articles.dart';

class Category extends StatefulWidget {
  final String category;
  Category({this.category});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNews newsObj = CategoryNews();
    await newsObj.getNews(widget.category);
    articles = newsObj.news;
    setState(() {
      loading = false;
    });
  }

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
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.save)),
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.only(top: 16.0),
                      child: ListView.builder(
                          itemCount: articles.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ContentTile(
                              imageUrl: articles[index].urlToImage,
                              title: articles[index].title,
                              desc: articles[index].description,
                              url: articles[index].url,
                            );
                          }),
                    ),
                  ])),
            ),
    );
  }
}

class ContentTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String desc;
  final String url;
  ContentTile(
      {@required this.imageUrl,
      @required this.desc,
      @required this.title,
      @required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Article(
                      articleUrl: url,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl)),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            desc,
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ]),
      ),
    );
  }
}
