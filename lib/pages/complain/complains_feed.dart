import 'package:flutter/material.dart';
import 'package:itrack24/pages/complain/complain_sort_buttons.dart';
import 'package:itrack24/pages/complain/complain_list_tile.dart';
import 'package:itrack24/scoped-models/main.dart';
import 'package:itrack24/widgets/ui_elements/default_side_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class ComplainsFeedPage extends StatefulWidget {
  final MainModel _model;

  ComplainsFeedPage(this._model);

  @override
  _ComplainsFeedPageState createState() => _ComplainsFeedPageState();
}

class _ComplainsFeedPageState extends State<ComplainsFeedPage> {
  @override
  void initState() {
    super.initState();
    widget._model.fetchComplains(widget._model.user.userId);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget _buildFloatingActionButton() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/ComplainEditPage');
          },
          tooltip: 'Add a Complain',
          backgroundColor: Colors.black87,
          child: Icon(Icons.add),
        );
      },
    );
  }

  Widget _bottomAppBar(GlobalKey<ScaffoldState> _scaffoldKey) {
    return BottomAppBar(
      color: Colors.red[800],
      notchMargin: 7.0,
      // elevation: 20.0,
      shape: CircularNotchedRectangle(),
      child: Container(
        height: 50.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
            ComplainSortButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildComplainFeed(MainModel model) {
    Widget content = model.finalComplainList.length == 0
        ? Center(
            child: Text(
              'No complains added, Please add some',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        : ListView.builder(
            itemCount: model.finalComplainList.length,
            itemBuilder: (BuildContext context, int index) {
              return ComplainListTile(model.finalComplainList[index], model);
            });
    return RefreshIndicator(
      child: content,
      onRefresh: () => model.fetchComplains(model.user.userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      drawer: DefaultSideDrawer(),
      body: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          return model.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _buildComplainFeed(model);
        },
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: _bottomAppBar(_scaffoldKey),
    );
  }
}
