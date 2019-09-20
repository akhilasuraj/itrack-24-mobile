import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itrack24/scoped-models/main.dart';

class ImageUploadWindow extends StatefulWidget {
  final MainModel _model;

  ImageUploadWindow(this._model);

  @override
  _ImageUploadWindowState createState() => _ImageUploadWindowState();
}

class _ImageUploadWindowState extends State<ImageUploadWindow> {
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(7.0),
        ),
        child: AspectRatio(
          aspectRatio: 16 / 8,
          child: Image.file(
            widget._model.pickedImage,
            fit: BoxFit.cover,
            alignment: FractionalOffset.center,
          ),
        ),
      ),
    );
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
    return _buildImageUploadWindow();
  }
}
