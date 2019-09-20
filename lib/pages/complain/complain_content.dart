import 'package:flutter/material.dart';
import 'package:itrack24/models/complain.dart';
import 'package:itrack24/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ComplainContentPage extends StatefulWidget {
  final MainModel _model;
  final int complainId;

  ComplainContentPage(this.complainId, this._model);

  @override
  _ComplainContentPageState createState() => _ComplainContentPageState();
}

class _ComplainContentPageState extends State<ComplainContentPage> {

  Widget _buildComplainContent() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        model.selectedComplain =
            model.finalComplainList.firstWhere((Complain comp) {
          return comp.complainId == widget.complainId;
        });
        return Container(
          padding: EdgeInsets.only(
            top: 30.0,
            left: 10.0,
            right: 10.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  model.selectedComplain.category ??
                      'Complain Category ' +
                          model.selectedComplain.complainId.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 37.0,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.date_range,
                      color: Colors.black26,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      model.selectedComplain.date,
                      style: TextStyle(color: Colors.black38),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Icon(
                      Icons.access_time,
                      color: Colors.black26,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      model.selectedComplain.time,
                      style: TextStyle(color: Colors.black38),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: AspectRatio(
                    aspectRatio: 16 / 8,
                    child: FadeInImage(
                      image: NetworkImage(
                          '${model.hostUrl}/${model.selectedComplain.complainImage}'),
                      fit: BoxFit.cover,
                      alignment: FractionalOffset.center,
                      placeholder: AssetImage('assets/android.jpg'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  model.selectedComplain.description ?? 'Complain Description',
                  style: TextStyle(
                      fontSize: 22.0, height: 1.3, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  drawer: DefaultSideDrawer(),
      body: _buildComplainContent(),
     // floatingActionButton: _buildFab(),
    );
  }

}
