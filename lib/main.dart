import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'scoped-models/main.dart';

import './pages/auth.dart';
import 'pages/complaints.dart';

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
              _isAuthenticated ? ComplaintsPage() : AuthPage(),
          '/complaints': (BuildContext context) =>
              _isAuthenticated ? ComplaintsPage() : AuthPage(),
        },
      ),
    );
  }
}
