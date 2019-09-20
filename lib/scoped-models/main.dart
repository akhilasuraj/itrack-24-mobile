import 'package:itrack24/scoped-models/complaints.dart';
import 'package:itrack24/scoped-models/date_time.dart';
import 'package:itrack24/scoped-models/image.dart';
import 'package:itrack24/scoped-models/location.dart';
import 'package:itrack24/scoped-models/user.dart';
import 'package:itrack24/scoped-models/news.dart';
import 'package:itrack24/scoped-models/utility.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model
    with
        UtilityModel,
        ImageModel,
        UserModel,
        ComplaintsModel,
        NewsModel,
        LocationModel,
        DateTimeModal {}
