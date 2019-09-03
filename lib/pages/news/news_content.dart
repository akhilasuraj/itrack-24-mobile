import 'package:flutter/material.dart';
import 'package:itrack24/models/news.dart';
import 'package:itrack24/scoped-models/main.dart';
import 'package:itrack24/widgets/ui_elements/default_side_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsContentPage extends StatefulWidget {
  final int newsId;
  MainModel _model;

  NewsContentPage(this.newsId,this._model);

  @override
  _NewsContentPageState createState() => _NewsContentPageState();
}

class _NewsContentPageState extends State<NewsContentPage> {

  Widget _buildNewsContent() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        model.selectedNews = model.finalNewsList.firstWhere((News news) {
          return news.newsId == widget.newsId;
        });

        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: 30.0,
              left: 10.0,
              right: 10.0,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  model.selectedNews.newsTitle ??
                      'News Title ' + model.selectedNews.newsId.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 37.0,
                  ),
                ),
                Text(
                  'by ' +
                      model.selectedNews.firstName +
                      ' ' +
                      model.selectedNews.lastName,
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
                      model.selectedNews.date,
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
                      image: NetworkImage('${model.hostUrl}/${model.selectedNews.imageUrl}'),
                      fit: BoxFit.cover,
                      alignment: FractionalOffset.topCenter,
                      placeholder: AssetImage('assets/android.jpg'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  model.selectedNews.newsContent ?? 'News Content',
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

  Widget _buildFab() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
          child: model.user.userId == model.selectedNews.userId
              ? FloatingActionButton(
                  backgroundColor: Colors.black87,
                  onPressed: () {
                   Navigator.pushNamed(context, '/NewsEditPage');
                  },
                  child: Icon(
                    Icons.edit,
                  ),
                )
              : Container(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DefaultSideDrawer(),
      body: _buildNewsContent(),
      floatingActionButton: _buildFab(),
    );
  }

  @override
  void dispose() {
    widget._model.selectedNews = null;
    widget._model.isEdit = false;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget._model.isEdit = true;
  }

}
