import 'package:flutter/material.dart';
import 'package:itrack24/models/news.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped-models/main.dart';

class NewsCard extends StatelessWidget {
  final News news;

  NewsCard(this.news);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/NewsContent/' + news.newsId.toString());
      },
      child: Card(
        margin: EdgeInsets.only(top: 6.0, right: 9.0, left: 9.0, bottom: 7.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 8,
                child: ScopedModelDescendant(
                  builder:
                      (BuildContext context, Widget child, MainModel model) {
                    return Hero(tag: '${this.news.newsId}',
                      child: FadeInImage(
                        image: NetworkImage('${model.hostUrl}/${this.news.imageUrl}'),
                        fit: BoxFit.cover,
                        alignment: FractionalOffset.center,
                        placeholder: AssetImage('assets/android.jpg'),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                news.newsTitle ?? 'Default News Title',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
