import 'package:itrack24/models/location.dart';
import 'package:scoped_model/scoped_model.dart';

mixin LocationModel on Model {
  Location _currentLocation;

  Location get currentLocation {
    return _currentLocation;
  }

  set currentLocation(Location loc) {
    _currentLocation = loc;
    notifyListeners();
  }
}
