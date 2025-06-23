import 'dart:convert';
import 'package:TrippyAlpapp/core/httpRequests/http.dart';
import 'package:TrippyAlpapp/core/sharedPref/sharedpreferences.dart';
import 'package:TrippyAlpapp/core/sharedPref/sharedprefkeynames.dart';
import 'package:flutter/material.dart';

class User {
  int? userId;
  String userKAdi;
  String? userPassword;
  String userName;
  String? token;
  String userMail;
  int userGender;

  String? userPermissionLevel;
  String? userStartDate;
  String? userBirthdate;
  String? userTC;
  String? userGsm;
  String? userAdres;
  String? userIl;
  String? userIlce;

  UserStatus userStatus;

  NetworkImage userProfilePhoto;
  NetworkImage userPThumbNail;

  List<String>? platformId;

  User({
    this.userId,
    required this.userKAdi,
    this.userPassword,
    this.token,
    required this.userMail,
    this.userGender = 0,
    this.userPermissionLevel,
    this.userStartDate,
    this.userTC,
    this.platformId,
    this.userAdres,
    this.userStatus = UserStatus.notApproved,
    this.userIl,
    this.userIlce,
    this.userGsm,
    required this.userName,
    this.userBirthdate,
    this.userPThumbNail = const NetworkImage(
        'https://st3.depositphotos.com/8361896/34679/v/600/depositphotos_346793456-stock-video-beautiful-abstract-holographic-gradient-rainbow.jpg'),
    this.userProfilePhoto = const NetworkImage(
        'https://dev.elektronikey.com/assets/user-avatar.png'),
  });

  static User? userProfile;
  static bool biometrics = true;

  static Future<Map<String, dynamic>?> register_account(
      Map<String, dynamic> data) async {
    Map returns = await HTTP_Requests.sendPostRequest('user', data);
    print(returns);
    if (returns['id'] == 0) {
      return returns['result'];
    } else {
      return {'error_message': returns['error_message']};
    }
  }

  static Future<bool> chekMailKey(Map<String, dynamic> data) async {
    Map returns = await HTTP_Requests.sendPostRequest('user', data);
    print(returns);
    if (returns['id'] == 0) {
      SharedPref.addStringToSF(
          userToken, returns['kullanici']['kullanici_secretToken']);
      String path = '';
      if (returns['kullanici']['kullanici_resim'] != null) {
        path = returns['kullanici']['kullanici_resim'];
      } else {
        path = 'https://dev.elektronikey.com/assets/user-avatar.png';
      }
      userProfile = _createUserParamater(returns['kullanici'], path);
      biometrics = false;
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateUser(Map<String, dynamic> data) async {
    Map returns = await HTTP_Requests.sendPostRequest('user', data);
    print(data);
    print(returns);
    if (returns['id'] == 0) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> resendMailCode(Map<String, dynamic> data) async {
    Map returns = await HTTP_Requests.sendPostRequest('user', data);
    print(returns);
    if (returns['id'] == 0) {
      return true;
    } else {
      return false;
    }
  }

  static String userParamaterForGET() =>
      'kullanici_id=${User.userProfile!.userId!}';

  static Future<bool> fetchUserbyToken(token) async {
    Map<String, dynamic> data = {'fetchUserByToken': 'ok', 'userToken': token};
    Map returns = await HTTP_Requests.sendPostRequest('user', data);
    /* List a = await  */
    print(returns);

    if (returns['id'] == 0) {
      SharedPref.addStringToSF(
          userToken, returns['kullanici']['kullanici_secretToken']);

      String path = '';
      if (returns['kullanici']['kullanici_resim'] != null) {
        path = returns['kullanici']['kullanici_resim'];
      } else {
        path = 'https://dev.elektronikey.com/assets/user-avatar.png';
      }

      /* List<dynamic> _platforms = returns['kullanici']['platforms']; */
      List<String> _canPlatformList = [];

      /* for (var element in _platforms) {
        _canPlatformList.add(element['kullanici_platformTokens_platformId']);
      } */
      print(returns['kullanici']);

      userProfile = _createUserParamater(returns['kullanici'], path);

      return true;
    } else {
      return false;
    }
  }

  static User _createUserParamater(Map returns, String path) {
    List<String> _canPlatformList = [];
    return User(
        userId: returns['kullanici_id'],
        token: returns['kullanici_secretToken'],
        userKAdi: '${returns['kullanici_ad']}',
        userPassword: '${returns['kullanici_password']}',
        userName: '${returns['kullanici_adsoyad']}',
        userMail: '${returns['kullanici_mail']}',
        userStatus: userStatusChecker('${returns['kullanici_durum']}'),
        userProfilePhoto: NetworkImage(path),
        userPermissionLevel: returns['kullanici_yetki'],
        userStartDate: '${returns['kullanici_zaman']}',
        platformId: _canPlatformList,
        userGender: int.parse(returns['kullanici_gender']),
        userBirthdate: returns['kullanici_birthDate'],
        userAdres: returns['kullanici_adres'],
        userIl: returns['kullanici_il'],
        userIlce: returns['kullanici_ilce'],
        userGsm: returns['kullanici_gsm'],
        userTC: returns['kullanici_tc']);
  }

  static UserStatus userStatusChecker(String status) {
    switch (status) {
      case '1':
        return UserStatus.approved;
      case '0':
        return UserStatus.notApproved;
      case '-1':
        return UserStatus.banned;
      default:
        return UserStatus.approved;
    }
  }

  static Future<Map> fetchUserbyMail(String mail, String password) async {
    Map<String, dynamic> data = {
      'fetchUserByMail': 'ok',
      'kullanici_mail': mail,
      'kullanici_password': password
    };

    print(data);
    Map returns = await HTTP_Requests.sendPostRequest('user', data);

    /* List a = await  */

    if (returns['id'] == 0) {
      SharedPref.addStringToSF(
          userToken, returns['kullanici']['kullanici_secretToken']);

      String path = '';
      if (returns['kullanici']['kullanici_resim'] != null) {
        path = returns['kullanici']['kullanici_resim'];
      } else {
        path = 'https://dev.elektronikey.com/assets/user-avatar.png';
      }

      List<String> _canPlatformList = [];

      userProfile = _createUserParamater(returns['kullanici'], path);
      biometrics = false;

      return {'id': 0, 'error_message': 'Giriş Başarılı!'};
    } else {
      return returns;
    }
  }

  static void logout() => userProfile = null;

  static List<User> initUserByList(List users) {
    List<User> _users = [];
    for (var element in users) {
      _users.add(
        User(
          userKAdi: element['kullanici_ad'],
          userId: element['kullanici_id'],
          userMail: element['kullanici_mail'],
          userName: element['kullanici_adsoyad'],
        ),
      );
    }
    return _users;
  }

  static Map productAdder() {
    Map user = {
      'id': userProfile!.userId,
      'userMail': userProfile!.userMail,
      'userName': userProfile!.userName
    };
    return user;
  }
}

enum UserStatus { approved, notApproved, banned }
