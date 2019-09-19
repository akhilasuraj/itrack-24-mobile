import 'package:flutter/material.dart';
import 'package:itrack24/models/complain.dart';
import 'package:itrack24/pages/complain/image_upload.dart';
import 'package:itrack24/pages/complain/location_input.dart';
import 'package:itrack24/scoped-models/main.dart';
import 'package:itrack24/widgets/ui_elements/date_time.dart';
import 'package:itrack24/widgets/ui_elements/default_bottom_navbar.dart';
import 'package:itrack24/widgets/ui_elements/default_side_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class ComplainEditPage extends StatefulWidget {
  final MainModel _model;

  ComplainEditPage(this._model);

  @override
  _ComplainEditPageState createState() => _ComplainEditPageState();
}

enum LocationMode {
  Map,
  Address,
}

class _ComplainEditPageState extends State<ComplainEditPage> {
  LocationMode _locationMode = LocationMode.Map;

  bool _isHidden = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _descriptionTextController =
      new TextEditingController();
  TextEditingController _address1TextController = new TextEditingController();
  TextEditingController _address2TextController = new TextEditingController();
  TextEditingController _districtTextController = new TextEditingController();

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

  Widget _buildAddressInputForm() {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _address1TextController,
          textAlign: TextAlign.center,
          maxLines: null,
          decoration: InputDecoration(
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
            filled: true,
            hintText: 'Address line 1',
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: _address2TextController,
          textAlign: TextAlign.center,
          maxLines: null,
          decoration: InputDecoration(
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
            filled: true,
            hintText: 'Address line 2',
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: _districtTextController,
          textAlign: TextAlign.center,
          maxLines: null,
          decoration: InputDecoration(
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
            filled: true,
            hintText: 'District',
          ),
        ),
      ],
    );
  }

  Widget _buildLocationModeButtonRow() {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(25.0),
      ),
      child: Stack(
        children: <Widget>[
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: _locationMode == LocationMode.Map ? 0 : MediaQuery.of(context).size.width/2 -25,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 2+ 15,
                height: 50,
                color: Colors.amber,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.black),
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.transparent,
            ),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLocationModeButton('Map', LocationMode.Map),
                _buildLocationModeButton('Address', LocationMode.Address),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationModeButton(String title, LocationMode mode) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _locationMode = mode;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 12,
        height: 48,
        color: Colors.transparent,
        child: Center(
            child: Text(
          title,
          style: TextStyle(color: _locationMode == mode ? Colors.black : Colors.grey,
              fontSize: _locationMode == mode ? 22.0 : 14.0,
              fontWeight: FontWeight.w700),
        )),
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
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
      child: SingleChildScrollView(
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
                    'Date and Time :',
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
              DateTimePicker(),
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
              _buildLocationModeButtonRow(),
              SizedBox(
                height: 10.0,
              ),
              _locationMode == LocationMode.Map
                  ? LocationInputWindow(widget._model)
                  : _buildAddressInputForm(),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
      ),
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
            if (_locationMode == LocationMode.Address) {
              if (_address1TextController.text.isEmpty ||
                  _address1TextController.text == null ||
                  _address2TextController.text.isEmpty ||
                  _address2TextController.text == null ||
                  _districtTextController.text.isEmpty ||
                  _districtTextController.text == null) {
                Scaffold.of(context).showSnackBar(snackBar);
                return;
              }
            }
            Complain generatedComplain = Complain(
              userId: model.user.userId,
              category: _selectedComplainCategory,
              description: _descriptionTextController.text,
              longitude:_locationMode == LocationMode.Map ? widget._model.currentLocation.lng : null,
              latitude: _locationMode == LocationMode.Map ? widget._model.currentLocation.lat : null,
              time: null,
              date: null,
              district: _districtTextController.text,
              address2: _address2TextController.text,
              complainImage: null,
              complainId: null,
              address1: _address1TextController.text,
            );
            await model.submitComplain(generatedComplain);
            Navigator.pushReplacementNamed(context, '/complaints');
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
