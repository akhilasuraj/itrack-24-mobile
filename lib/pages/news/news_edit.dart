import 'package:flutter/material.dart';
import 'package:itrack24/models/news.dart';
import 'package:itrack24/scoped-models/main.dart';
import 'package:itrack24/widgets/ui_elements/default_bottom_navbar.dart';
import 'package:itrack24/widgets/ui_elements/default_side_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsEditPage extends StatefulWidget {
  final bool isEdit;
  final News editableNews;

  NewsEditPage(this.isEdit, {this.editableNews});

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
          onPressed: () {
            _formKey.currentState.save();
            model.submitNews(_formData['newsTitle'], _formData['newsContent']);
            Navigator.pushNamed(context, '/newsFeed');
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
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 8,
        child: FadeInImage(
          image: NetworkImage(
              'https://assets.pcmag.com/media/images/555832-google-pixel-3a.jpg?width=810&height=456'),
          fit: BoxFit.cover,
          alignment: FractionalOffset.topCenter,
          placeholder: AssetImage('assets/android.jpg'),
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
              Row(
                children: <Widget>[
                  Text(
                    'Title :',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              _buildNewsTitleFormField(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DefaultSideDrawer(),
      body: _buildNewsSubmitFormField(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: defaultBottomAppBar(_scaffoldKey),
    );
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
