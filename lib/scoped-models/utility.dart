import 'package:scoped_model/scoped_model.dart';

mixin UtilityModel on Model {
  final String _hostUrl = 'http://192.168.8.8:3000';

  String get hostUrl {
    return _hostUrl;
  }

  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool status) {
    _isLoading = status;
    notifyListeners();
  }
}
