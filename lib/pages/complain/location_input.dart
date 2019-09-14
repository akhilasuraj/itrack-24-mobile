import 'package:flutter/material.dart';

class LocationInputWindow extends StatefulWidget {
  @override
  _LocationInputWindowState createState() => _LocationInputWindowState();
}

class _LocationInputWindowState extends State<LocationInputWindow> {
  final TextEditingController _locationInputController =
      TextEditingController();

  Widget _buildLocationInputFormField() {
    return TextFormField(
      controller: _locationInputController,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        suffixIcon:
            IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: () {}),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildLocationInputFormField(),
      ],
    );
  }
}
