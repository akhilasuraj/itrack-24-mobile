import 'package:flutter/cupertino.dart';

class Complain {
  final int complainId;
  final int userId;
  final String category;
  final String description;
  final String complainImage;
  final String address1;
  final String address2;
  final String district;
  final String date;
  final String time;
  final double longitude;
  final double latitude;
  final bool isViwedByUser;
  final bool isViwedCompletedByUser;
  final bool isViwedByAdmin;
  final bool isAccepted;
  final bool isRejected;
  final bool isAssigned;
  final bool isCompleted;
  final String reason;

  Complain({
    @required this.complainId,
    @required this.userId,
    @required this.category,
    @required this.description,
    @required this.complainImage,
    @required this.address1,
    @required this.address2,
    @required this.district,
    @required this.date,
    @required this.time,
    @required this.latitude,
    @required this.longitude,
    @required this.isAccepted,
    @required this.isAssigned,
    @required this.isCompleted,
    @required this.isRejected,
    @required this.isViwedByAdmin,
    @required this.isViwedByUser,
    @required this.isViwedCompletedByUser,
    @required this.reason,
  });
}
