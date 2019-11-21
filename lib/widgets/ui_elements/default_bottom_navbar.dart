import 'package:flutter/material.dart';

Widget defaultBottomAppBar(GlobalKey<ScaffoldState> _scaffoldKey,BuildContext context) {
  return BottomAppBar(
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
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}