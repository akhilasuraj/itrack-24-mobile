import 'dart:convert';

import 'package:itrack24/models/complain.dart';
import 'package:itrack24/scoped-models/image.dart';
import 'package:itrack24/scoped-models/user.dart';
import 'package:itrack24/scoped-models/utility.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

mixin ComplaintsModel on Model, UtilityModel, ImageModel, UserModel {
  List<Complain> _finalComplainList;
  Complain _selectedComplain;

  Complain get selectedComplain {
    return _selectedComplain;
  }

  set selectedComplain(Complain comp) {
    _selectedComplain = comp;
  }

  List<Complain> get finalComplainList {
    return _finalComplainList;
  }

  Future<bool> fetchComplains(int userId) async {
    isLoading = true;
    try {
      final http.Response response = await http.post(
        '$hostUrl/users/getallcomplains',
        body: json.encode({'user_id': userId}),
        headers: {'content-type': 'application/json'},
      );
      final List fetchedComplains = json.decode(response.body);
      print(fetchedComplains);
      final List<Complain> fetchedComplainsList = [];
      fetchedComplains.forEach((complain) {
        Complain fetchedComplainElement = Complain(
          complainId: complain['id'],
          userId: complain['user_id'],
          category: complain['category'],
          description: complain['description'],
          complainImage: complain['complainImg'],
          address1: complain['address1'],
          address2: complain['address2'],
          district: complain['district'],
          date: complain['date'],
          time: complain['time'],
          latitude: complain['latitude'],
          longitude: complain['longitude'],
          isAccepted: complain['isAccepted'],
          isAssigned: complain['isAssigned'],
          isCompleted: complain['isCompleted'],
          isRejected: complain['isRejected'],
          isViwedByAdmin: complain['isViwedByAdmin'],
          isViwedByUser: complain['isViwedByUser'],
          isViwedCompletedByUser: complain['isViwedCompletedByUser'],
          reason: complain['reason'],
        );
        fetchedComplainsList.add(fetchedComplainElement);
      });
      _finalComplainList = fetchedComplainsList;
    } catch (e) {
      isLoading = false;
      return false;
    }
    isLoading = false;
    return true;
  }

  Future<bool> submitComplain(Complain complain) async {
    isLoading = true;
    try {
      final Map<String, String> _complainDetails = {
        'user_id': user.userId.toString(),
        'category': complain.category,
        'description': complain.description,
        'longitude': complain.longitude.toString(),
        'latitude': complain.latitude.toString(),
        'address1': complain.address1,
        'address2': complain.address2,
        'district': complain.district,
        'date': complain.date,
        'time': complain.time,
      };

      final bool state =
          await uploadImage('/users/complain', 'compImg', _complainDetails);
      print(state);
    } catch (e) {
      print(e);
      isLoading = false;
      return false;
    }
    isLoading = false;
    return true;
  }

  Future<bool> deleteComplain(int complainId) async {
    isLoading = true;
    try {
      final http.Response response = await http.post(
        '$hostUrl/users/deletecomplains',
        body: json.encode({'id': complainId}),
        headers: {'content-type': 'application/json'},
      );
      final List responseData = json.decode(response.body);
      print(responseData);
    } catch (e) {
      print(e);
      isLoading = false;
      return false;
    }
    isLoading = false;
    return true;
  }
}
