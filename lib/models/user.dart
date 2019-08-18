import 'package:flutter/material.dart';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String token;
  final int userId;

  User({
    @required this.firstName,
    @required this.email,
    @required this.lastName,
    @required this.token,
    @required this.userId,
  });
}
