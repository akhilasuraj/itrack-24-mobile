import 'package:flutter/material.dart';
import 'package:itrack24/models/news.dart';
import 'package:itrack24/scoped-models/main.dart';
import 'package:itrack24/widgets/ui_elements/default_side_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsContentPage extends StatefulWidget {
  final int newsId;
  final MainModel _model;

  NewsContentPage(this.newsId, this._model);

  @override
  _NewsContentPageState createState() => _NewsContentPageState();
}

class _NewsContentPageState extends State<NewsContentPage> {
  bool _deleting = false;

  Widget _buildNewsContent() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        model.selectedNews = model.finalNewsList.firstWhere((News news) {
          return news.newsId == widget.newsId;
        }, orElse: () => null);
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: 30.0,
              left: 10.0,
              right: 10.0,bottom: 80.0
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
                      Icons.date_range,
                      color: Colors.black26,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      model.selectedNews.date,
                      style: TextStyle(color: Colors.black38),
                    ),
                    SizedBox(width: 10.0,),
                    Icon(
                      Icons.access_time,
                      color: Colors.black26,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      model.selectedNews.time,
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
                    child: Hero(tag: '${model.selectedNews.newsId}',
                      child: FadeInImage(
                        image: NetworkImage(
                            '${model.hostUrl}/${model.selectedNews.imageUrl}'),
                        fit: BoxFit.cover,
                        alignment: FractionalOffset.center,
                        placeholder: AssetImage('assets/android.jpg'),
                      ),
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
        return model.user.userId == model.selectedNews.userId
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: 'delete',
                    backgroundColor: Colors.red,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Alert !'),
                            content:
                                Text('Do you realy want to delete this News ?'),
                            actions: <Widget>[
                              FlatButton(
                                  child: Text('Yes'),
                                  onPressed: () async {
                                    setState(() {
                                      _deleting = true;
                                    });
                                    model.isLoading = true;
                                    model.isEdit = false;
                                    await model.deleteNews(context);

                                    Navigator.pushReplacementNamed(
                                        context, '/newsFeed');
                                  }),
                              FlatButton(
                                  child: Text('No'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  })
                            ],
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.delete,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  FloatingActionButton(
                    heroTag: 'blackFab',
                    backgroundColor: Colors.black87,
                    onPressed: () {
                      Navigator.pushNamed(context, '/NewsEditPage');
                    },
                    child: Icon(
                      Icons.edit,
                    ),
                  )
                ],
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return (widget._model.isLoading)
        ? Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : (_deleting == true)
            ? Scaffold(
                body: Container(),
              )
            : Scaffold(
                drawer: DefaultSideDrawer(widget._model),
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
