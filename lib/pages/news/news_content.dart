import 'package:flutter/material.dart';
import 'package:itrack24/models/news.dart';
import 'package:itrack24/scoped-models/main.dart';
import 'package:itrack24/widgets/ui_elements/default_side_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsContentPage extends StatelessWidget {
  final int newsId;
  News _selectedNews;

  NewsContentPage(this.newsId);

  Widget _buildNewsContent() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        _selectedNews = model.finalNewsList.firstWhere((News news) {
          return news.newsId == newsId;
        });

        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
            child: Column(
              children: <Widget>[
                Text(
                  _selectedNews.newsTitle ??
                      'News Title ' + _selectedNews.newsId.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 37.0,
                  ),
                ),
                Text(
                  'by' + _selectedNews.firstName + ' ' + _selectedNews.lastName,
                  style: TextStyle(fontSize: 16.0, color: Colors.black26),
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: Colors.black26,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      _selectedNews.date,
                      style: TextStyle(color: Colors.black38),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: AspectRatio(
                    aspectRatio: 16 / 8,
                    child: FadeInImage(
                      image: NetworkImage(
                          'https://assets.pcmag.com/media/images/555832-google-pixel-3a.jpg?width=810&height=456'),
                      fit: BoxFit.cover,
                      alignment: FractionalOffset.topCenter,
                      placeholder: AssetImage('assets/android.jpg'),
                    ),
                  ),
                ),
                SizedBox(height: 15.0,),
                Text(
                  _selectedNews.newsContent ?? 'News Content',
                  style: TextStyle(
                      fontSize: 22.0, height: 1.3, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DefaultSideDrawer(),
      body: _buildNewsContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.edit),
      ),
    );
  }
}
