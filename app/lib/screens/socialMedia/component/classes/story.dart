import 'package:flutter/material.dart';

class Story {
  final String userName;
  final NetworkImage storyPhoto;
  bool seen;

  Story({required this.userName, required this.storyPhoto, this.seen = false});
}
