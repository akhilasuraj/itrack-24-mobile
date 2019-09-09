import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'logout_list_tile.dart';
import '../../scoped-models/main.dart';

class DefaultSideDrawer extends StatelessWidget {
  final String _backgroundImageUrl =
      'https://images.pexels.com/photos/1229042/pexels-photo-1229042.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940';
  final String _currentProfPicUrl =
      'https://freehindistatus.com/wp-content/uploads/2018/05/cute-baby-whatsapp-profile-300x300.jpg';

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return (model.user != null)
            ? Drawer(
                child: ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text(
                          '${model.user.firstName} ${model.user.lastName}'),
                      accountEmail: Text(model.user.email),
                      currentAccountPicture: GestureDetector(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(_currentProfPicUrl),
                        ),
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(_backgroundImageUrl),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('News Feed'),
                      leading: Icon(Icons.chat),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/newsFeed');
                      },
                    ),
                    ListTile(
                      title: Text('Complains'),
                      leading: Icon(Icons.hourglass_empty),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/complaints');
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Settings'),
                      leading: Icon(Icons.settings),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                            context, '/SettingsMainPage');
                      },
                    ),
                    ListTile(
                      title: Text('Contact us'),
                      leading: Icon(Icons.call),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/ContactPage');
                      },
                    ),
                    Divider(),
                    LogoutListTile(),
                  ],
                ),
              )
            : Container();
      },
    );
  }
}
