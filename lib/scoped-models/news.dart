import 'dart:convert';

import 'package:itrack24/models/news.dart';
import 'package:itrack24/scoped-models/image.dart';
import 'package:itrack24/scoped-models/user.dart';
import 'package:itrack24/scoped-models/utility.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

mixin NewsModel on Model, UtilityModel, UserModel,ImageModel {
  List<News> _finalNewsList = List();
  News _selectedNews;
  bool _isEdit;

  bool get isEdit {
    return _isEdit;
  }

  set isEdit(bool stat) {
    _isEdit = stat;
    notifyListeners();
  }

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
        newsContent: news['PostText'],
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

  Future<Null> submitNews(String newsTitle, String newsContent) async {
    isLoading = true;
    await uploadImage('/users/addimage');
    final Map<String, dynamic> _newsDetails = {
      'UserID': user.userId,
      'FirstName': user.firstName,
      'LastName': user.lastName,
      'PostTitle': newsTitle,
      'PostText': newsContent,
      'PostImg': null,
    };
    final http.Response response = await http.post(
      '$hostUrl/users/addpost',
      body: json.encode(_newsDetails),
      headers: {'content-type': 'application/json'},
    );
    isLoading = false;
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
  }
}
