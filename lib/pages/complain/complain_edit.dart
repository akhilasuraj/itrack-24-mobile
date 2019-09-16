import 'package:flutter/material.dart';
import 'package:itrack24/pages/complain/image_upload.dart';
import 'package:itrack24/pages/complain/location_input.dart';
import 'package:itrack24/scoped-models/main.dart';
import 'package:itrack24/widgets/ui_elements/default_bottom_navbar.dart';
import 'package:itrack24/widgets/ui_elements/default_side_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class ComplainEditPage extends StatefulWidget {
  final MainModel _model;

  ComplainEditPage(this._model);

  @override
  _ComplainEditPageState createState() => _ComplainEditPageState();
}

class _ComplainEditPageState extends State<ComplainEditPage> {
  bool _isHidden = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _descriptionTextController =
      new TextEditingController();
  String _selectedComplainCategory;
  List<String> _complainHeadingList = [
    'Emergency on street',
    'Drainage Blocking',
    'Solid Waste Removal',
    'Removel of Tree Cutting Debris',
    'Other',
  ];
  List<List<String>> _complainCategoryList = [
    [
      'Stret-Signal post',
      'Street-Pedestrian crossing',
      'Street-lamp',
      'Street-Color light',
      'Street-Dangerous tree',
      'Street-Dangerous construction area',
    ],
    [
      'Drainage Blockage-house',
      'Drainage Blockage-Public building',
      'Drainage Blockage-Road',
    ],
    [
      'Solid waste-house',
      'Solid waste-Public premises',
    ],
    [
      'Tree Cutting Debris-house',
      'Tree Cutting Debris-Public premises',
    ],
    [
      'Mosquito breeding area',
    ]
  ];

  Widget _buildDescriptionFormField() {
    return TextFormField(
      controller: _descriptionTextController,
      textAlign: TextAlign.center,
      maxLines: null,
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
        filled: true,
        hintText: 'Complain Description',
      ),
    );
  }

  Widget _buildCategoryText() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isHidden = false;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1.0, color: Colors.transparent),
          borderRadius: BorderRadius.circular(25.0),
        ),
        padding: EdgeInsets.all(15.0),
        child: Text(
          _selectedComplainCategory ?? 'Tap to Select a category',
          style: TextStyle(
              fontSize: 16.0,
              color: _selectedComplainCategory == null
                  ? Colors.black54
                  : Colors.black),
        ),
      ),
    );
  }

  Widget _buildComplainCategory() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: <Widget>[
            _buildCategoryText(),
            _isHidden
                ? Container()
                : Divider(
                    color: Colors.black,
                    indent: 20.0,
                    endIndent: 20.0,
                  ),
            _buildCategorySelectionList(),
            //!_isHidden ? _buildCategorySelectionList() : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelectionList() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      height: _isHidden ? 0.0 : 300.0,
      child: Scrollbar(
        child: ListView.builder(
          itemCount: _complainHeadingList.length,
          itemBuilder: (BuildContext context, int x) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        _complainHeadingList[x],
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500),
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                ),
                ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _complainCategoryList[x].length,
                  itemBuilder: (BuildContext context, int y) {
                    return FlatButton(
                      onPressed: () {
                        setState(() {
                          _selectedComplainCategory =
                              _complainCategoryList[x][y];
                          _isHidden = true;
                        });
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 15.0,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 10.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(_complainCategoryList[x][y]),
                          Expanded(child: Container())
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10.0,
                )
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber,
      key: _scaffoldKey,
      extendBody: true,
      drawer: DefaultSideDrawer(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: defaultBottomAppBar(_scaffoldKey),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 60.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Category :',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              _buildComplainCategory(),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Description :',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              _buildDescriptionFormField(),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Image :',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              ImageUploadWindow(widget._model),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Location :',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              LocationInputWindow(),
            ],
          )),
    );
  }

  final SnackBar snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text('Please fill all the fields !'),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  // Find the Scaffold in the widget tree and use
  // it to show a SnackBar.

  Widget _buildFloatingActionButton() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return FloatingActionButton(
          onPressed: () async {
            Scaffold.of(context).hideCurrentSnackBar();
            if (_descriptionTextController.text.isEmpty ||
                _descriptionTextController.text == null ||
                _selectedComplainCategory.isEmpty ||
                _selectedComplainCategory == null ||
                widget._model.pickedImage == null) {

              Scaffold.of(context).showSnackBar(snackBar);
              return;
            }
          },
          tooltip: 'Submit',
          backgroundColor: Colors.black87,
          child: Icon(Icons.check),
        );
      },
    );
  }

  @override
  void dispose() {
    widget._model.pickedImage = null;
    super.dispose();
  }
}
