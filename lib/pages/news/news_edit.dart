import 'package:flutter/material.dart';
import 'package:itrack24/widgets/ui_elements/default_bottom_navbar.dart';

class NewsEditPage extends StatelessWidget {
  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      tooltip: 'Add a news',
      backgroundColor: Colors.black87,
      child: Icon(Icons.check),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
      body: Container(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: defaultBottomAppBar(_scaffoldKey),
    );
  }
}
