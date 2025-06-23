import 'package:TrippyAlpapp/core/classes/user.dart';
import 'package:flutter/material.dart';

class MenuType {
  final String name;
  final IconData icon;
  MenuType({required this.icon, required this.name});
}

class Desk {
  final int deskCount;
  final bool canReserved;
  final String name;
  Desk(
      {required this.canReserved, required this.deskCount, required this.name});
}

class ProsCons {
  final List<String> pros;
  final List<String> cons;

  ProsCons({required this.cons, required this.pros});
}

class Comments {
  final User commentOwner;
  final String commentContent;
  final String commentDate;

  Comments(
      {required this.commentContent,
      required this.commentDate,
      required this.commentOwner});
}

class WorkingTimes {
  final String dayName;
  final int openingTime;
  final int closingTime;
  WorkingTimes(
      {required this.closingTime,
      required this.dayName,
      required this.openingTime});
}
