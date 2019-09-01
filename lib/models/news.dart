import 'package:flutter/cupertino.dart';

class News {
  final int newsId;
  final int userId;
  final String firstName;
  final String lastName;
  final String newsTitle;
  final String newsContent;
  final String date;
  final String time;

  News({
    @required this.newsId,
    @required this.userId,
    @required this.firstName,
    @required this.lastName,
    @required this.newsTitle,
    @required this.newsContent,
    @required this.date,
    @required this.time,
  });
}
