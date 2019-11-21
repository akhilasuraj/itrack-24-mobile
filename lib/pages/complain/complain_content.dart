import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:itrack24/models/complain.dart';
import 'package:itrack24/scoped-models/main.dart';
import 'package:itrack24/widgets/ui_elements/default_side_drawer.dart';
import 'package:itrack24/widgets/utils/map_image.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ComplainContentPage extends StatefulWidget {
  final int complainId;
  final MainModel _model;

  ComplainContentPage(
    this.complainId,
    this._model,
  );

  @override
  _ComplainContentPageState createState() => _ComplainContentPageState();
}

class _ComplainContentPageState extends State<ComplainContentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  Widget _buildComplainContent() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        Color statusColor = Colors.grey;
        String statusBadge = 'W';
        String status = 'Waiting';
        if (widget._model.selectedComplain.isRejected) {
          statusColor = Colors.red;
          statusBadge = '!';
          status = 'Rejected';
        }
        if (widget._model.selectedComplain.isAccepted) {
          statusColor = Colors.white;
          statusBadge = 'Ac';
          status = 'Accepted';
        }
        if (widget._model.selectedComplain.isAssigned) {
          statusColor = Colors.amber;
          statusBadge = 'On';
          status = 'Ongoing';
        }
        if (widget._model.selectedComplain.isCompleted) {
          statusColor = Colors.greenAccent[700];
          statusBadge = 'C';
          status = 'Completed';
        }
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
                Text(
                  '(Complain ID = ${model.selectedComplain.complainId})',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
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
                    Chip(
                      avatar: CircleAvatar(
                        backgroundColor: statusColor,
                        child: Text(statusBadge),
                      ),
                      label: Text(status),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Divider(),
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
                SizedBox(
                  height: 15.0,
                ),
                Divider(),
                model.selectedComplain.longitude != null
                    ? Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              openMap(widget._model.selectedComplain.latitude,
                                  widget._model.selectedComplain.longitude);
                            },
                            child: MapImageWindow(
                                model,
                                model.selectedComplain.latitude,
                                model.selectedComplain.longitude),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          model.currentLocation == null
                              ? Container()
                              : Text(
                                  model.currentLocation.address,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                  ),
                                ),
                        ],
                      )
                    : _buildAddressDisplayPanel(),
                Container(
                  height: 80.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddressDisplayPanel() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Address : ',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 25.0),
            ),
          ),
          Align(
            alignment: Alignment(-0.25, 0.0),
            child: Text(
              widget._model.selectedComplain.address1 +
                  '\n' +
                  widget._model.selectedComplain.address2 +
                  '\n' +
                  widget._model.selectedComplain.district,
              style: TextStyle(fontSize: 25.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFab() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
          child: FloatingActionButton(
            heroTag: 'blackFab',
            backgroundColor: Colors.redAccent,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Alert..!'),
                    content: Text('Are you sure you want to delete ?'),
                    actions: <Widget>[
                      model.isLoading
                          ? CircularProgressIndicator()
                          : FlatButton(
                              child: Text('yes'),
                              onPressed: () async {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                final bool stat = await model
                                    .deleteComplain(widget.complainId);
                                print(stat);
                              },
                            ),
                      FlatButton(
                        child: Text('no'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                },
              );
            },
            child: Icon(
              Icons.delete,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    widget._model.selectedComplain =
        widget._model.finalComplainList.firstWhere((Complain comp) {
      return comp.complainId == widget.complainId;
    });
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      drawer: DefaultSideDrawer(widget._model),
      body: _buildComplainContent(),
      floatingActionButton: (widget._model.selectedComplain.isRejected ||
              widget._model.selectedComplain.isAccepted)
          ? Container()
          : _buildFab(),
//      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//      bottomNavigationBar: defaultBottomAppBar(_scaffoldKey, context),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget._model.fetchComplains(widget._model.user.userId);
    widget._model.selectedComplain = null;
  }
}
