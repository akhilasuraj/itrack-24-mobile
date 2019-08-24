import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';

import 'dart:convert';
import 'dart:async';

import '../models/auth.dart';
import '../models/user.dart';

mixin ConnectedModel on Model {
  final String _hostUrl = 'http://192.168.8.8:3000';

  User _authenticatedUser;
  bool _isLoading = false;
}

mixin UtilityModel on ConnectedModel {
  bool get isLoading {
    return _isLoading;
  }
}

mixin UserModel on ConnectedModel {
  PublishSubject<bool> _userSubject = PublishSubject();

  User get user {
    return _authenticatedUser;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  Future<Map<String, dynamic>> authenticate(Map<String, dynamic> formData,
      [AuthMode mode = AuthMode.Login]) async {
    _isLoading = true;
    notifyListeners();
    http.Response response;
    String message = 'Something went wrong';
    bool hasError = true;
    final Map<String, dynamic> loginFormData = {
      'email': formData['email'],
      'password': formData['password'],
    };

    if (mode == AuthMode.Login) {
      response = await http.post(
        '$_hostUrl/users/login',
        body: json.encode(loginFormData),
        headers: {'content-type': 'application/json'},
      );
    } else {
      response = await http.post(
        '$_hostUrl/users/register',
        body: json.encode(formData),
        headers: {'content-type': 'application/json'},
      );
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    if (responseData.containsKey('token')) {
      hasError = false;
      message = 'Authentication Succeeded';
      _authenticatedUser = User(
        firstName: responseData['firstName'],
        email: formData['email'],
        lastName: responseData['lastName'],
        token: responseData['token'],
        userId: responseData['userId'],
      );
      _userSubject.add(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('firstName', responseData['firstName']);
      prefs.setString('lastName', responseData['lastName']);
      prefs.setInt('userId', responseData['userId']);
      prefs.setString('token', responseData['token']);
      prefs.setString('email', formData['email']);
    } else if (responseData['error'] == 'INVALID_PASSWORD') {
      message = 'Invalid password';
    } else if (responseData['error'] == 'USER_DOES_NOT_EXIST') {
      message = 'User does not exist';
    } else if (responseData['error'] == 'USER_ALREADY_EXISTS') {
      message = 'User already exist';
    }
    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  void autoAuthenticate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    if (token != null) {
      _authenticatedUser = User(
        firstName: prefs.getString('firstName'),
        email: prefs.getString('email'),
        lastName: prefs.getString('lastName'),
        token: prefs.getString('token'),
        userId: prefs.getInt('userId'),
      );
      _userSubject.add(true);
      notifyListeners();
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('firstName');
    prefs.remove('lastName');
    prefs.remove('userId');
    prefs.remove('email');
    prefs.remove('token');
    _userSubject.add(false);
    _authenticatedUser = null;
    notifyListeners();
  }
}
