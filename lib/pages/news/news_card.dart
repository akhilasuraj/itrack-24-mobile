import 'package:flutter/material.dart';
import 'package:itrack24/models/news.dart';

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
        margin: EdgeInsets.only(top: 13.0, right: 9.0, left: 9.0),
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
                child: FadeInImage(
                  image: NetworkImage(
                      'https://assets.pcmag.com/media/images/555832-google-pixel-3a.jpg?width=810&height=456'),
                  fit: BoxFit.cover,
                  alignment: FractionalOffset.topCenter,
                  placeholder: AssetImage('assets/android.jpg'),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                news.newsTitle ??
                    'Default News Title',
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
