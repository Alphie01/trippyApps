import 'package:flutter/material.dart';

class User {
  int? userId;
  String userKAdi;
  String userPassword;
  String? userName;
  String userMail;
  String? userTitle;
  int? userPermissionLevel;
  String? userStartDate;
  String? userBirthdate;

  NetworkImage userProfilePhoto;
  NetworkImage userPThumbNail;
  List<User> userFollowing;
  List<User> userFollowers;

  User({
    this.userId,
    required this.userKAdi,
    required this.userPassword,
    required this.userMail,
    this.userPermissionLevel,
    this.userStartDate,
    this.userName,
    this.userTitle,
    this.userBirthdate,
    this.userFollowers = const [],
    this.userFollowing = const [],
    this.userPThumbNail = const NetworkImage(
        'https://st3.depositphotos.com/8361896/34679/v/600/depositphotos_346793456-stock-video-beautiful-abstract-holographic-gradient-rainbow.jpg'),
    this.userProfilePhoto = const NetworkImage(
        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
  });

  static User userProfile = User(
    userId: 1,
    userKAdi: 'admin',
    userPassword: 'userPassword',
    userName: 'userName',
    userTitle: 'userTitle',
    userMail: 'alpsel3@gmail.com',
    userProfilePhoto: NetworkImage(
        'https://www.webwise.ie/wp-content/uploads/2020/12/IMG1207.jpg'),
    userFollowing: [],
    userPermissionLevel: 5,
    userStartDate: '11.22.2023',
  );
}
