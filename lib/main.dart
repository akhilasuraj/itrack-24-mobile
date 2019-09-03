import 'package:flutter/material.dart';
import 'package:itrack24/pages/news/news_content.dart';
import 'package:itrack24/pages/news/news_edit.dart';
import 'package:itrack24/pages/news/news_feed.dart';
import 'package:scoped_model/scoped_model.dart';

import 'scoped-models/main.dart';

import './pages/auth.dart';
import 'pages/complain/complaints.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _model.isEdit = false;
    _model.autoAuthenticate();
    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.red,
          accentColor: Colors.deepPurple,
          buttonColor: Colors.deepOrange,
        ),
        routes: {
          '/': (BuildContext context) =>
              _isAuthenticated ? NewsFeedPage(_model) : AuthPage(),
          '/complaints': (BuildContext context) =>
              _isAuthenticated ? ComplaintsPage() : AuthPage(),
          '/newsFeed': (BuildContext context) =>
              _isAuthenticated ? NewsFeedPage(_model) : AuthPage(),
          '/NewsEditPage': (BuildContext context) =>
          _isAuthenticated ? NewsEditPage(_model.isEdit,_model, editableNews: _model.selectedNews) : AuthPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (!_isAuthenticated) {
            MaterialPageRoute(builder: (BuildContext context) => AuthPage());
          }
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'NewsContent') {
            final int newsId = int.parse(pathElements[2]);
            return MaterialPageRoute(
              builder: (BuildContext context) =>
                  _isAuthenticated ? NewsContentPage(newsId,_model) : AuthPage(),
            );
          }
          return null;
        },
      ),
    );
  }
}
