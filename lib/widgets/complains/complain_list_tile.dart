import 'package:flutter/material.dart';
import 'package:itrack24/models/complain.dart';
import 'package:itrack24/scoped-models/main.dart';

class ComplainListTile extends StatelessWidget {
  final Complain complain;
  final MainModel _model;

  ComplainListTile(this.complain, this._model);

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.grey;
    String statusBadge = 'W';
    String status = 'Waiting';
    if (complain.isRejected) {
      statusColor = Colors.red;
      statusBadge = '!';
      status = 'Rejected';
    }
    if (complain.isAccepted) {
      statusColor = Colors.white;
      statusBadge = 'Ac';
      status = 'Accepted';
    }
    if (complain.isAssigned) {
      statusColor = Colors.amber;
      statusBadge = 'On';
      status = 'Ongoing';
    }
    if (complain.isCompleted) {
      statusColor = Colors.greenAccent[700];
      statusBadge = 'C';
      status = 'Completed';
    }
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
            context, '/ComplainContent/' + complain.complainId.toString());
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:
              NetworkImage('${_model.hostUrl}/${complain.complainImage}'),
        ),
        title: Text(complain.category),
        subtitle: Text(
          complain.description,
          maxLines: 1,
        ),
        trailing: Chip(
          avatar: CircleAvatar(
            backgroundColor: statusColor,
            child: Text(statusBadge),
          ),
          label: Text(status),
        ),
      ),
    );
  }
}
