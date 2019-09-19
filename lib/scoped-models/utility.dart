import 'package:scoped_model/scoped_model.dart';

mixin UtilityModel on Model {
  final String _hostUrl = 'http://192.168.8.8:3000';
  bool _isEdit;

  bool get isEdit {
    return _isEdit;
  }

  set isEdit(bool stat) {
    _isEdit = stat;
    notifyListeners();
  }

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
