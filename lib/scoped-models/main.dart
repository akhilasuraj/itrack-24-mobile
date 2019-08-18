import 'package:scoped_model/scoped_model.dart';

import 'connected-models.dart';

class MainModel extends Model with ConnectedModel, UserModel, UtilityModel {}
