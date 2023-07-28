import 'dart:io';

import 'package:TrippyAlpapp/constants/theme.dart';
import 'package:TrippyAlpapp/navigator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Flutter UI Templates',
      debugShowCheckedModeBanner: false,
      color: AppTheme.firstColor,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        platform: TargetPlatform.iOS,
      ),

      //home: WelcomePage(),,
      home: AppNavigatorScreen(),
      /*home: WelcomeScreen(
          animationController: AnimationController(
              duration: const Duration(milliseconds: 600), vsync: this)),*/
      /*home: SocialMediaScreen(
          animationController: AnimationController(
              duration: const Duration(milliseconds: 600), vsync: this)),*/
    );
  }
}
