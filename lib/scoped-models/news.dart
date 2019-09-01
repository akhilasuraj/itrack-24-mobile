import 'dart:convert';

import 'package:itrack24/models/news.dart';
import 'package:itrack24/scoped-models/User.dart';
import 'package:itrack24/scoped-models/utility.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

mixin NewsModel on Model, UtilityModel, UserModel {
  List<News> _finalNewsList = List();

  Future<Null> fetchNews() async {
    isLoading = true;
    final http.Response response = await http.get('$hostUrl/users/viewposts');

    final List fetchedNews = json.decode(response.body);
    print(fetchedNews);
    final List<News> fetchedNewsList = [];
    fetchedNews.forEach((news) {
      News fetchedNewsElement = News(
        newsId: news['id'],
        userId: news['UserID'],
        firstName: news['FirstName'],
        lastName: news['LastName'],
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
    final Map<String,dynamic> responseData = json.decode(response.body);
    print(responseData);

  }
}
