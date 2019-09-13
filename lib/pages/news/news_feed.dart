import 'package:flutter/material.dart';
import 'package:itrack24/pages/news/news_card.dart';
import 'package:itrack24/scoped-models/main.dart';
import 'package:itrack24/widgets/ui_elements/default_bottom_navbar.dart';
import 'package:itrack24/widgets/ui_elements/default_side_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsFeedPage extends StatefulWidget {
  final MainModel model;

  NewsFeedPage(this.model);

  @override
  _NewsFeedPageState createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  @override
  initState() {
    super.initState();
    widget.model.fetchNews();
  }

  Widget _buildNewsFeed(MainModel model) {
    Widget content = model.finalNewsList.isEmpty
        ? Container(
            child: Center(
              child: Text('No news yet, please add some'),
            ),
          )
        : ListView.builder(
            itemCount: model.finalNewsList.length,
            itemBuilder: (BuildContext context, int index) {
              return NewsCard(model.finalNewsList[index]);
            },
          );
    return RefreshIndicator(
      onRefresh: model.fetchNews,
      child: content,
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/NewsEditPage');
      },
      tooltip: 'Add a news',
      backgroundColor: Colors.black87,
      child: Icon(Icons.add),
    );
  }

  Future<bool> _willPop(BuildContext context) async {
    if (!(Navigator.canPop(context)))
      return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Alert !'),
                content: Text('Do you realy want to exit from the app ?'),
                actions: <Widget>[
                  FlatButton(
                      child: Text('Yes'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      }),
                  FlatButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      })
                ],
              );
            },
          ) ??
          false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: () => _willPop(context),
      child: Scaffold(
        key: _scaffoldKey,
        extendBody: true,
        drawer: DefaultSideDrawer(),
        body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            return model.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _buildNewsFeed(model);
          },
        ),
        floatingActionButton: _buildFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: defaultBottomAppBar(_scaffoldKey),
      ),
    );
  }
}
