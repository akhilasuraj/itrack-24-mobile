import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LocationInputWindow extends StatefulWidget {
  @override
  _LocationInputWindowState createState() => _LocationInputWindowState();
}

class _LocationInputWindowState extends State<LocationInputWindow> {
  Uri mapImageUri;
  Uri geocodeUri;
  final TextEditingController _locationInputController =
      TextEditingController();

  Widget _buildLocationInputFormField() {
    return TextFormField(
      controller: _locationInputController,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: () {
            setState(() {
              _updateLocation();
            });
          },
        ),
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
        filled: true,
        hintText: 'Enter address here',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Location Cannot be empty';
        }
        return null;
      },
    );
  }

  void _buildStaticMap(String address) async {
    if (address.length < 2) {
      return;
    }

    geocodeUri = Uri.https(
      'maps.googleapis.com',
      '/maps/api/geocode/json',
      {'address': address, 'key': 'AIzaSyBjTh5fhWEMqiDEtMYmmQyVfNYdvNcB39A'},
    );
    print(geocodeUri.toString());

    final http.Response response = await http.get(geocodeUri.toString());
    final decodedResponse = json.decode(response.body);
    print(decodedResponse);
    final formattedAddress = decodedResponse['results'][0]['formatted_address'];
    final coords = decodedResponse['results'][0]['geometry']['location'];

    setState(() {
      _locationInputController.text = formattedAddress;
    });

    mapImageUri = Uri.https(
      'maps.googleapis.com',
      '/maps/api/staticmap',
      {
        'size': '1280x720',
        'zoom': '18',
        'center': '${coords['lat']},${coords['lng']}',
        'maptype': 'roadmap',
        'key': 'AIzaSyBjTh5fhWEMqiDEtMYmmQyVfNYdvNcB39A'
      },
    );
  }

  void _updateLocation() {
    print(_locationInputController.text);
    _buildStaticMap(_locationInputController.text);
  }

  Widget _buildCapturedMapImage() {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          mapImageUri.toString(),
          fit: BoxFit.cover,
          alignment: FractionalOffset.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildLocationInputFormField(),
        SizedBox(
          height: 10.0,
        ),
        _buildCapturedMapImage(),
      ],
    );
  }
}
