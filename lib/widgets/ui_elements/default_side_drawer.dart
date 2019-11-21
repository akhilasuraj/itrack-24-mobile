import 'package:flutter/material.dart';

import 'logout_list_tile.dart';
import '../../scoped-models/main.dart';

class DefaultSideDrawer extends StatelessWidget {
  final MainModel _model;

  DefaultSideDrawer(this._model);

  final String _backgroundImageUrl =
      'https://images.pexels.com/photos/1229042/pexels-photo-1229042.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940';
  final String _currentProfPicUrl =
      'https://freehindistatus.com/wp-content/uploads/2018/05/cute-baby-whatsapp-profile-300x300.jpg';

  @override
  Widget build(BuildContext context) {
    return (_model.user != null)
        ? Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName:
                      Text('${_model.user.firstName} ${_model.user.lastName}'),
                  accountEmail: Text(_model.user.email),
                  currentAccountPicture: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/ProfileDetails');
                    },
                    child: Hero(tag: '${_model.user.userId}',
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(_currentProfPicUrl),
                      ),
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
                    //   Navigator.popUntil(context, ModalRoute.withName('/newsFeed'));
//                    Navigator.of(context).pop();
//                    Navigator.pushReplacementNamed(context, '/newsFeed');
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/newsFeed', (Route<dynamic> route) => false);
                  },
                ),
                ListTile(
                  title: Text('Complains'),
                  leading: Icon(Icons.hourglass_empty),
                  onTap: () {
                    //  Navigator.of(context).pushNamedAndRemoveUntil('/complaints', ModalRoute.withName('/newsFeed'));
//                    Navigator.of(context).pop();
//                    Navigator.pushNamed(context, '/complaints');
                   Navigator.of(context)
                        .pushNamedAndRemoveUntil('/complaints', (Route<dynamic> route) => false);
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Settings'),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    //Navigator.of(context).pushNamedAndRemoveUntil('/SettingsMainPage', ModalRoute.withName('/newsFeed'));
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/SettingsMainPage');
                  },
                ),
                ListTile(
                  title: Text('Contact us'),
                  leading: Icon(Icons.call),
                  onTap: () {
                    //Navigator.of(context).pushNamedAndRemoveUntil('/ContactPage', ModalRoute.withName('/newsFeed'));
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/ContactPage');

                  },
                ),
                Divider(),
                LogoutListTile(),
              ],
            ),
          )
        : Container();
  }
}
