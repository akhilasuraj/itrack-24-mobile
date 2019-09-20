import 'package:flutter/material.dart';
import 'package:itrack24/models/complain.dart';
import 'package:itrack24/scoped-models/main.dart';

class ComplainListTile extends StatelessWidget {
  final Complain complain;
  final MainModel _model;

  ComplainListTile(this.complain, this._model);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/ComplainContent/' + complain.complainId.toString());
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:
              NetworkImage('${_model.hostUrl}/${complain.complainImage}'),
        ),
        title: Text(complain.category),
        subtitle: Text(complain.description),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.edit),
        ),
      ),
    );
  }
}
