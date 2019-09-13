import 'package:flutter/material.dart';

class ComplainSortButtons extends StatefulWidget {
  @override
  _ComplainSortButtonsState createState() => _ComplainSortButtonsState();
}

class _ComplainSortButtonsState extends State<ComplainSortButtons> {
  Widget _buildAllComplains() {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.apps,
        color: Colors.black,
      ),
    );
  }

  Widget _buildAcceptedComplains() {
    return Container(
      height: 50.0,
      color: Colors.white10,
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.done_outline,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildAllComplains(),
        _buildAcceptedComplains(),
      ],
    );
  }
}
