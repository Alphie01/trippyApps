import 'package:TrippyAlpapp/constants/sharedPreferencesKeynames.dart';
import 'package:TrippyAlpapp/constants/theme.dart';
import 'package:TrippyAlpapp/core/sharedPreferences.dart';
import 'package:TrippyAlpapp/functions/lastScreens.dart';
import 'package:TrippyAlpapp/screens/createNewPost/createNew.dart';
import 'package:TrippyAlpapp/screens/enterence/appInfo/appInfo.dart';
import 'package:TrippyAlpapp/screens/enterence/loading/loading.dart';
import 'package:TrippyAlpapp/screens/enterence/login/login.dart';
import 'package:TrippyAlpapp/screens/enterence/openingPage/welcome.dart';
import 'package:TrippyAlpapp/screens/enterence/register/register.dart';
import 'package:TrippyAlpapp/screens/essencials/drawers.dart';
import 'package:TrippyAlpapp/screens/guide/guideScreen.dart';
import 'package:TrippyAlpapp/screens/searchScreen/searchScreen.dart';
import 'package:TrippyAlpapp/screens/shopping/shopping.dart';
import 'package:TrippyAlpapp/screens/socialMedia/socailMediaPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TrippyAlpapp/constants/sizeConfig.dart';

class AppNavigatorScreen extends StatefulWidget {
  final int pagecount;

  const AppNavigatorScreen({Key? key, this.pagecount = 0}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AppNavigatorScreenState createState() => _AppNavigatorScreenState();
}

class _AppNavigatorScreenState extends State<AppNavigatorScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  // ignore: unused_field
  Animation<double>? _animation;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  // ignore: prefer_final_fields
  Lastscreens _lastscreens = Lastscreens();
  List tryed = [{}];
  bool bottombar = true, darkTheme = false;

  Widget tabBody = Container(
    color: AppTheme.firstColor,
  );

  int startingPage = 90;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval((1 / 9) * 0, 1.0, curve: Curves.fastOutSlowIn)));
    checkStartingPage();

    _lastscreens.addLastScreen(startingPage);
    _updateBar(pageId: startingPage);

    super.initState();
  }

  Future checkStartingPage() async {
    await SharedPref.getSharedInstance();
    print(SharedPref.getStringValuesSF(userToken));

    // ignore: unnecessary_null_comparison
    if (SharedPref.getBoolValuesSF(isShownWelcomeInfos)) {
      setState(() {
        startingPage = 92;
      });
    }

    if (SharedPref.getStringValuesSF(userToken) != '') {
      setState(() {
        startingPage = 94;
      });
    }

    if (SharedPref.getBoolValuesSF(darkOrLightMode)) {
      AppTheme.setDarkTheme();
      setState(() {
        darkTheme = true;
      });
    }

    _updateBar(pageId: startingPage);
  }

  int currIndex = 0;
  void _updateBar({int pageId = 0, List<dynamic> pageContent = const []}) {
    print(pageId);
    _lastscreens.addLastScreen(pageId);
    animationController?.reverse().then<dynamic>((data) {
      if (!mounted) {
        return;
      }

      switch (pageId) {
        //socail Media

        case 0:
          setState(() {
            bottombar = true;
            tabBody = SocialMediaScreen(
              animationController: animationController,
              updatePage: _updateBar,
              scaffoldKey: scaffoldKey,
            );
          });
          break;

        //search
        case 20:
          setState(() {
            bottombar = true;
            tabBody = SearchScreen(
              animationController: animationController,
              updatePage: _updateBar,
              scaffoldKey: scaffoldKey,
            );
          });
          break;

        //add newPost pageId : 40
        case 40:
          setState(() {
            bottombar = true;
            tabBody = CreateNewScreen(
              animationController: animationController,
              updatePage: _updateBar,
              scaffoldKey: scaffoldKey,
            );
          });
          break;

        // map pageId : 60
        case 60:
          setState(() {
            bottombar = true;
            tabBody = MapViewScreen(
              animation: _animation,
              animationController: animationController,
              updatePage: _updateBar,
            );
          });
          break;

        //login - Register - Welcome Pages
        case 90:
          setState(() {
            bottombar = false;
            tabBody = WelcomeScreen(
              animationController: animationController,
              updatePage: _updateBar,
            );
          });
          break;

        case 91:
          setState(() {
            bottombar = false;
            tabBody = AppInfo(
              animationController: animationController,
              updatePage: _updateBar,
            );
          });
          break;

        case 92:
          setState(() {
            bottombar = false;
            tabBody = LoginScreen(
              animationController: animationController,
              updatePage: _updateBar,
            );
          });
          break;

        case 93:
          setState(() {
            bottombar = false;
            tabBody = RegisterScreen(
              animationController: animationController,
              updatePage: _updateBar,
            );
          });
          break;
        case 94:
          setState(() {
            bottombar = false;
            tabBody = LoadingScreen(
              animationController: animationController,
              updatePage: _updateBar,
            );
          });
          break;

        case 120:
          setState(() {
            tabBody = ShoppingPage();
          });

        default:
          setState(() {
            tabBody = WelcomeScreen(
              animationController: animationController,
              updatePage: _updateBar,
            );
          });
      }
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SharedPref.init();
    return Container(
      color: AppTheme.background,
      child: bottombar
          ? Scaffold(
              key: scaffoldKey,
              drawer: Drawer(
                backgroundColor: AppTheme.background,
                child: Drawers(
                  darkTheme: darkTheme,
                  updatePage: _updateBar,
                ),
              ),
              bottomNavigationBar: CurvedNavigationBar(
                index: currIndex,
                backgroundColor: AppTheme.firstColor.withOpacity(.3),
                height: 50,
                color: AppTheme.background,
                items: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.home,
                    color: AppTheme.textColor,
                  ),
                  FaIcon(
                    FontAwesomeIcons.search,
                    color: AppTheme.textColor,
                  ),
                  FaIcon(
                    FontAwesomeIcons.plus,
                    color: AppTheme.textColor,
                  ),
                  FaIcon(
                    FontAwesomeIcons.map,
                    color: AppTheme.textColor,
                  ),
                  FaIcon(
                    FontAwesomeIcons.shoppingBag,
                    color: AppTheme.textColor,
                  ),
                ],
                onTap: (index) {
                  switch (index) {
                    case 0:
                      _updateBar(pageId: 0);
                      break;
                    case 1:
                      _updateBar(pageId: 20);
                      break;
                    case 2:
                      _updateBar(pageId: 40);
                      break;
                    case 3:
                      _updateBar(pageId: 60);
                      break;
                    case 4:
                      _updateBar(pageId: 120);
                      break;
                    default:
                  }
                },
              ),
              backgroundColor: Colors.transparent,
              body: FutureBuilder<bool>(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  } else {
                    return Stack(
                      children: <Widget>[tabBody],
                    );
                  }
                },
              ),
            )
          : Scaffold(
              backgroundColor: Colors.transparent,
              body: FutureBuilder<bool>(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  } else {
                    return Stack(
                      children: <Widget>[tabBody],
                    );
                  }
                },
              ),
            ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
