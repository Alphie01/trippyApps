import 'dart:io';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/navigator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
/* import 'package:google_mobile_ads/google_mobile_ads.dart'; */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /* MobileAds.instance.initialize(); */
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
      statusBarIconBrightness: AppTheme.background == AppBlackTheme.background
          ? Brightness.dark
          : Brightness.light,
      statusBarBrightness: AppTheme.background == AppBlackTheme.background
          ? Brightness.dark
          : Brightness.light,
      systemNavigationBarColor: AppTheme.textColor,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness:
          AppTheme.background == AppBlackTheme.background
              ? Brightness.dark
              : Brightness.light,
    ));
    return MaterialApp(
      title: 'Flutter UI Templates',
      debugShowCheckedModeBanner: false,
      color: AppTheme.firstColor,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        platform: TargetPlatform.iOS,
      ),
      home: AppNavigatorScreen(),
    );
  }
}
