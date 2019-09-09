import 'package:flutter/material.dart';
import 'package:itrack24/widgets/ui_elements/default_bottom_navbar.dart';
import 'package:itrack24/widgets/ui_elements/default_side_drawer.dart';


class ContactPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DefaultSideDrawer(),
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
      bottomNavigationBar: defaultBottomAppBar(_scaffoldKey),
    );
  }
}
