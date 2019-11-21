import 'package:flutter/material.dart';
import 'package:itrack24/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileDetails extends StatefulWidget {
  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  final String _currentProfPicUrl =
      'https://freehindistatus.com/wp-content/uploads/2018/05/cute-baby-whatsapp-profile-300x300.jpg';
  final String _backgroundImageUrl =
      'https://images.pexels.com/photos/1229042/pexels-photo-1229042.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940';
  Widget buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 3.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(_backgroundImageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildProfileImage(MainModel model) {
    return Center(
      child: Hero(tag: '${model.user.userId}',
        child: Container(
          width: 140.0,
          height: 140.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(_currentProfPicUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(80.0),
            border: Border.all(
              color: Colors.white,
              width: 10.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFullName(MainModel model) {
    return Text(
      '${model.user.firstName} ${model.user.lastName}',
      style: TextStyle(
//      fontFamily:
        fontSize: 32.0,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    );
  }

  Widget buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        'User',
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 20.0,
          color: Colors.teal,
//            fontFamily:
        ),
      ),
    );
  }

  //  Widget buildStatContainer() {
//    TextStyle _statLabelTextStyle = TextStyle(
//      fontSize: 15.0,
//      fontWeight: FontWeight.w400,
//      color: Colors.black,
////      fontFamily:
//    );
//    TextStyle statCountTextStyle = TextStyle(
//      color: Colors.black54,
//      fontSize: 24.0,
//      fontWeight: FontWeight.bold,
//    );
//    return Container(
//      height: 60.0,
//      margin: EdgeInsets.only(top: 8.0),
//      decoration: BoxDecoration(
//        color: Colors.green,
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              buildCoverImage(screenSize),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: screenSize.height / 6.5,
                      ),
                      buildProfileImage(model),
                      buildFullName(model),
                      buildStatus(context),
                      Text('${model.user.email}')
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
