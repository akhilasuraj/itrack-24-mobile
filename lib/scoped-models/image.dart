import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:itrack24/scoped-models/utility.dart';
import 'package:mime/mime.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http_parser/http_parser.dart';

mixin ImageModel on Model, UtilityModel {

  File _pickedImage;

  set pickedImage(File image){
    _pickedImage = image;
    notifyListeners();
  }

  File get pickedImage{
    return _pickedImage;
  }

  Future<Null> uploadImage() async {
    final mimeTypeData = lookupMimeType(_pickedImage.path).split('/');
    final imageUploadRequest =
        http.MultipartRequest('POST', Uri.parse('$hostUrl/users/addimage'));
    final file = await http.MultipartFile.fromPath('postImg', _pickedImage.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    imageUploadRequest.files.add(file);
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if(response.statusCode != 200 && response.statusCode != 201){
        print('Something went wrong');
        print(json.decode(response.body));
        return null;
      }
      final responseData = json.decode(response.body);
      print(responseData);
    } catch (error) {
      print(error);
      return null;
    }
  }
}
