import 'package:flutter/material.dart';
import 'package:itrack24/scoped-models/main.dart';
import 'package:itrack24/widgets/ui_elements/default_side_drawer.dart';

class ContactPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final MainModel _model;

  ContactPage(this._model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DefaultSideDrawer(_model),
      body: Container(
        padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 5,
              child: Image.asset(
                'assets/logoTransparentBlack.png',
                fit: BoxFit.cover,
                alignment: FractionalOffset.center,
              ),
            ),
            Text('Contact Details'),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal,
        notchMargin: 7.0,
        // elevation: 20.0,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
