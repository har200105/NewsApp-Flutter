import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/models/ArticleModel.dart';
import 'package:newsapp/models/CategoryModel.dart';
import 'package:newsapp/views/articles.dart';
import 'package:newsapp/views/category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool loading = true;
  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getArticles();
  }

  getArticles() async {
    News newsObj = News();
    await newsObj.getNews();
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
                child: Column(
                children: [
                  Container(
                    height: 60,
                    child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return NewsTile(
                              imageUrl: categories[index].imageUrl,
                              categoryName: categories[index].categoryName);
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(top:16.0),
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
                ],
              )),
          ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final String imageUrl;
  final String categoryName;
  NewsTile({this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Category(category: categoryName.toLowerCase(),)));
      },
      child: Container(
          margin: EdgeInsets.only(right: 16),
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child:CachedNetworkImage(
                   imageUrl: imageUrl,
                    width: 120,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  ),
              Container(
                alignment: Alignment.center,
                width: 120,
                height: 60,
                // color: Colors.black26,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(categoryName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ],
          )),
    );
  }
}

class ContentTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String desc;
  final String url;
  ContentTile(
      {@required this.imageUrl, @required this.desc, @required this.title , @required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Article(
          articleUrl: url,
        )));
      },
          child: Container(
        margin: EdgeInsets.only(bottom:16),
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(imageUrl)),
          SizedBox(height:8),
          Text(title,style: TextStyle(
            fontSize:20,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),),
          SizedBox(height:8),
          Text(desc,style: TextStyle(
            color:Colors.black54,
          ),),
        ]),
      ),
    );
  }
}
