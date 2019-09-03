import 'package:itrack24/scoped-models/image.dart';
import 'package:itrack24/scoped-models/user.dart';
import 'package:itrack24/scoped-models/news.dart';
import 'package:itrack24/scoped-models/utility.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model
    with UtilityModel, UserModel, ImageModel, NewsModel {}
