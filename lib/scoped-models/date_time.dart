import 'package:scoped_model/scoped_model.dart';

mixin DateTimeModal on Model {
  String _date;
  String _time;

  String get date {
    return _date;
  }

  set date(String val) {
    _date = val;
  }

  String get time {
    return _time;
  }

  set time(String val) {
    _time = val;
  }
}
