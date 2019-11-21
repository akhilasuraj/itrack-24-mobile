import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:itrack24/models/news.dart';
import 'package:itrack24/scoped-models/image.dart';
import 'package:itrack24/scoped-models/user.dart';
import 'package:itrack24/scoped-models/utility.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

mixin NewsModel on Model, UtilityModel, UserModel, ImageModel {
  List<News> _finalNewsList = List();
  News _selectedNews;

  News get selectedNews {
    return _selectedNews;
  }

  set selectedNews(News news) {
    _selectedNews = news;
    notifyListeners();
  }

  Future<Null> fetchNews() async {
    isLoading = true;
    final http.Response response = await http.get('$hostUrl/users/viewposts');

    final List fetchedNews = json.decode(response.body);
    final List<News> fetchedNewsList = [];
    fetchedNews.forEach((news) {
      News fetchedNewsElement = News(
        newsId: news['id'],
        userId: news['UserID'],
        firstName: news['FirstName'],
        lastName: news['LastName'],
        imageUrl: news['PostImg'],
        newsTitle: news['PostTitle'],
        newsContent: news['PostContent'],
        date: news['PostDate'],
        time: news['PostTime'],
      );

      fetchedNewsList.add(fetchedNewsElement);
    });
    _finalNewsList = fetchedNewsList;
    isLoading = false;
  }

  List<News> get finalNewsList {
    return _finalNewsList;
  }

  Future<Null> deleteNews(BuildContext context) async {
    isLoading = true;
    _finalNewsList.removeWhere((news) => news.newsId == _selectedNews.newsId);
    final Map<String, int> _newsId = {
      'postid': _selectedNews.newsId,
    };
    // final http.Response response =
    await http.post(
      '$hostUrl/users/deletepost',
      body: json.encode(_newsId),
      headers: {'content-type': 'application/json'},
    );
    selectedNews = null;
    isLoading = false;
    // final Map<String, dynamic> responseData = json.decode(response.body);
    // print(responseData);
  }

  submitNews(String newsTitle, String newsContent) {
    isLoading = true;

    final Map<String, String> _newsDetails = {
      'UserID': user.userId.toString(),
      'FirstName': user.firstName,
      'LastName': user.lastName,
      'PostTitle': newsTitle,
      'PostContent': newsContent,
    };
    uploadImage('/users/addpost', 'postImg', _newsDetails);
    isLoading = false;
  }
}
