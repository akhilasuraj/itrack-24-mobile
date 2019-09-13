import 'package:flutter/material.dart';
import 'package:itrack24/models/complain.dart';

class ComplainListTile extends StatelessWidget {
  final Complain complain;

  ComplainListTile(this.complain);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(complain.complainImage),
      ),
      title: Text(complain.category),
      subtitle: Text(complain.description),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.edit),
      ),
    );
  }
}
