import 'package:app/globals/comments.dart';
import 'package:app/globals/users.dart';
import 'package:flutter/material.dart';

class PostClasses {
  final User postBelongs;
  final List<NetworkImage>? postImgs;
  final String? postString;
  final List<User> likedPerson;
  final List<Comments> comments;

  PostClasses(
      {this.postString,
      this.likedPerson = const [],
      this.comments = const [],
      required this.postBelongs,
      this.postImgs});
}
