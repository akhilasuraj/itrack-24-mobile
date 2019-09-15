import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itrack24/models/news.dart';
import 'package:itrack24/scoped-models/main.dart';
import 'package:itrack24/widgets/ui_elements/default_bottom_navbar.dart';
import 'package:itrack24/widgets/ui_elements/default_side_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsEditPage extends StatefulWidget {
  final bool isEdit;
  final News editableNews;
  final MainModel _model;

  NewsEditPage(this.isEdit, this._model, {this.editableNews});

  @override
  _NewsEditPageState createState() => _NewsEditPageState();
}

class _NewsEditPageState extends State<NewsEditPage> {
  TextEditingController newsTitleController = new TextEditingController();
  TextEditingController newsContentController = new TextEditingController();

  final Map<String, dynamic> _formData = {
    'newsTitle': null,
    'newsContent': null,
    'image': null,
  };

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Widget _buildFloatingActionButton() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return FloatingActionButton(
          onPressed: () async {
            if (!_formKey.currentState.validate() ||
                model.pickedImage == null) {
              return null;
            }
            _formKey.currentState.save();
            await model.submitNews(
                _formData['newsTitle'], _formData['newsContent']);
            Navigator.pushReplacementNamed(context, '/newsFeed');
          },
          tooltip: 'Add a news',
          backgroundColor: Colors.black87,
          child: Icon(Icons.check),
        );
      },
    );
  }

  Widget _buildNewsTitleFormField() {
    return TextFormField(
      controller: newsTitleController,
      textAlign: TextAlign.center,
      maxLength: 150,
      maxLines: null,
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
        filled: true,
        hintText: 'News Title',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Title Cannot be empty';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['newsTitle'] = value;
      },
    );
  }

  Widget _buildImageUploadWindow() {
    return GestureDetector(
        onTap: () => _buildImagePickerBottomSheet(context),
        child: widget._model.pickedImage == null
            ? _buildImageUploadButton()
            : _buildCapturedImage());
  }

  Widget _buildImageUploadButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.camera_alt,
            size: 30.0,
          ),
          SizedBox(width: 10.0),
          Text(
            'Pick an image',
            style: TextStyle(fontSize: 17.0),
          )
        ],
      ),
    );
  }

  Widget _buildCapturedImage() {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 8,
        child: Image.file(
          widget._model.pickedImage,
          fit: BoxFit.cover,
          alignment: FractionalOffset.center,
        ),
      ),
    );
  }

  Widget _buildNewsContentFormField() {
    return TextFormField(
      controller: newsContentController,
      textAlign: TextAlign.center,
      maxLines: null,
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
        filled: true,
        hintText: 'News Content',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Content Cannot be empty';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['newsContent'] = value;
      },
    );
  }

  Widget _buildNewsSubmitFormField() {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0, bottom: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Text('Title :',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700)),
                Expanded(child: Container())
              ]),
              SizedBox(height: 10.0),
              _buildNewsTitleFormField(),
              //SizedBox(height: 10.0),
              Row(children: <Widget>[
                Text('Image :',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700)),
                Expanded(child: Container())
              ]),
              SizedBox(height: 10.0),
              _buildImageUploadWindow(),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Text(
                    'Content :',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              _buildNewsContentFormField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheetButton(String text, Icon icon, ImageSource source) {
    return GestureDetector(
      onTap: () {
        _getImage(context, source);
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(width: 1.0),
            borderRadius: BorderRadius.circular(4.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            SizedBox(width: 10.0),
            Text(text, style: TextStyle(fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }

  void _buildImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an Image',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10.0),
                _buildBottomSheetButton(
                  'Camera',
                  Icon(Icons.camera_alt),
                  ImageSource.camera,
                ),
                SizedBox(height: 10.0),
                _buildBottomSheetButton(
                  'Gallery',
                  Icon(Icons.image),
                  ImageSource.gallery,
                )
              ],
            ),
          );
        });
  }

  void _getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source, maxWidth: 500);
    Navigator.pop(context);
    setState(() {
      widget._model.pickedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      drawer: DefaultSideDrawer(),
      body: _buildNewsSubmitFormField(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: defaultBottomAppBar(_scaffoldKey),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget._model.pickedImage = null;
  }

  @override
  void initState() {
    super.initState();

    if (widget.isEdit) {
      newsTitleController.text = widget.editableNews.newsTitle;
      newsContentController.text = widget.editableNews.newsContent;
    }
  }
}
