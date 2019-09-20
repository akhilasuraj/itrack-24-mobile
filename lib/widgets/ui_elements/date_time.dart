import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:itrack24/scoped-models/main.dart';

class DateTimePicker extends StatefulWidget {
  final MainModel _model;

  DateTimePicker(this._model);

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    widget._model.date = '${now.year}-${now.month}-${now.day}';
    widget._model.time = '${now.hour}:${now.minute}:${now.second}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 4.0,
              onPressed: () {
                DatePicker.showDatePicker(context,
                    theme: DatePickerTheme(
                      containerHeight: 210.0,
                    ),
                    showTitleActions: true,
                    minTime: DateTime(2000, 1, 1),
                    maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                  print('confirm $date');
                  widget._model.date = '${date.year}-${date.month}-${date.day}';
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.date_range,
                                size: 18.0,
                                color: Colors.black,
                              ),
                              Text(
                                " ${widget._model.date}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(
                      "  Change",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              color: Colors.white,
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 4.0,
              onPressed: () {
                DatePicker.showTimePicker(context,
                    theme: DatePickerTheme(
                      containerHeight: 210.0,
                    ),
                    showTitleActions: true, onConfirm: (time) {
                  print('confirm $time');
                  widget._model.time = '${time.hour}:${time.minute}:${time.second}';
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.en);
                setState(() {});
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                size: 18.0,
                                color: Colors.black,
                              ),
                              Text(
                                " ${widget._model.time}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(
                      "  Change",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
