import 'package:TrippyAlpapp/core/classes/bloc/current_placemark_cubit.dart';
import 'package:TrippyAlpapp/core/classes/bloc/maps_cubit.dart';
import 'package:TrippyAlpapp/core/classes/bloc/opacity_cubit.dart';
import 'package:TrippyAlpapp/core/constants/sizeconfig.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/core/lastScreens.dart';
import 'package:TrippyAlpapp/core/sharedPref/sharedpreferences.dart';
import 'package:TrippyAlpapp/core/sharedPref/sharedprefkeynames.dart';
import 'package:TrippyAlpapp/screens/essencial/drawer.dart';
import 'package:TrippyAlpapp/screens/homepage/homepage.dart';
import 'package:TrippyAlpapp/screens/places/bars/bars.dart';
import 'package:TrippyAlpapp/screens/profile/my_profile/my_profile.dart';
import 'package:TrippyAlpapp/screens/settings/settingsScreen.dart';
import 'package:TrippyAlpapp/screens/settings/sub_pages/account_privacy.dart';
import 'package:TrippyAlpapp/screens/settings/sub_pages/change_password.dart';
import 'package:TrippyAlpapp/screens/settings/sub_pages/data_saver.dart';

import 'package:TrippyAlpapp/screens/starting/appInfo/appInfo.dart';
import 'package:TrippyAlpapp/screens/starting/loading/loading.dart';
import 'package:TrippyAlpapp/screens/starting/login/login.dart';
import 'package:TrippyAlpapp/screens/starting/openingPage/welcome.dart';
import 'package:TrippyAlpapp/screens/starting/register/register.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  bool bottombar = true, darkTheme = false, isAuthed = false, isDrawer = true;

  Widget tabBody = Container(
    color: AppTheme.firstColor,
  );

  int startingPage = 90, pageViewPages = 1;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval((1 / 9) * 0, 1.0, curve: Curves.fastOutSlowIn)));
    _updateBar(pageId: startingPage);
    checkStartingPage();
    _lastscreens.addLastScreen(startingPage);
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

    if (SharedPref.getBoolValuesSF(dataSaverMode)) {
      setState(() {
        AppTheme.dataSaverMode = true;
      });
    }

    _updateBar(pageId: startingPage);
  }

  int currIndex = 0;
  void _updateBar({int pageId = 0, Map pageContent = const {}}) {
    setState(() {
      startingPage = pageId;
      isDrawer = true;
    });
    _lastscreens.addLastScreen(pageId);
    print(Lastscreens.lastscreens);

    animationController?.reverse().then<dynamic>((data) {
      if (!mounted) {
        return;
      }

      switch (pageId) {
        case 0:
          setState(() {
            currIndex = 0;
            bottombar = true;
            tabBody = HomeScreen(
              scaffoldKey: scaffoldKey,
              animation: _animation,
              animationController: animationController,
              updatePage: _updateBar,
              closeBottomBar: (bool selection) {
                setState(() {
                  bottombar = selection;
                });
              },
            );
          });
          break;

        case 1:
          setState(() {
            currIndex = 0;
            bottombar = true;
            tabBody = BarsScreen(
              scaffoldKey: scaffoldKey,
              animationController: animationController,
              updatePage: _updateBar,
            );
          });
          break;

        case 30:
          setState(() {
            currIndex = 2;
            bottombar = true;
            tabBody = MainSettingsPage(
              scaffoldKey: scaffoldKey,
              animationController: animationController,
              updatePage: _updateBar,
            );
          });
          break;

        case 31:
          setState(() {
            currIndex = 2;
            bottombar = true;
            tabBody = MyProfile(
              scaffoldKey: scaffoldKey,
              animationController: animationController,
              updatePage: _updateBar,
            );
          });
          break;

        case 33:
          setState(() {
            currIndex = 2;
            bottombar = true;
            tabBody = ChangePassword(
              scaffoldKey: scaffoldKey,
              animationController: animationController,
              updatePage: _updateBar,
            );
          });
          break;

        case 34:
          setState(() {
            currIndex = 2;
            bottombar = true;
            tabBody = AccountPrivacy(
              scaffoldKey: scaffoldKey,
              animationController: animationController,
              updatePage: _updateBar,
            );
          });
          break;

        case 44:
          setState(() {
            currIndex = 2;
            bottombar = true;
            tabBody = DataSaver(
              scaffoldKey: scaffoldKey,
              animationController: animationController,
              updatePage: _updateBar,
            );
          });
          break;

        case 90:
          setState(() {
            bottombar = false;
            isDrawer = false;
            tabBody = WelcomeScreen(
              animationController: animationController,
              updatePage: _updateBar,
            );
          });
          break;

        case 91:
          setState(() {
            bottombar = false;
            isDrawer = false;
            tabBody = AppInfo(
              animationController: animationController,
              updatePage: _updateBar,
            );
          });
          break;

        case 92:
          setState(() {
            bottombar = false;
            isDrawer = false;
            tabBody = LoginScreen(
              animationController: animationController,
              updatePage: _updateBar,
            );
          });
          break;

        case 93:
          setState(() {
            bottombar = false;
            isDrawer = false;
            tabBody = RegisterScreen(
              animationController: animationController,
              updatePage: _updateBar,
            );
          });
          break;
        case 94:
          setState(() {
            bottombar = false;
            isDrawer = false;
            tabBody = LoadingScreen(
              isOnlyThemeChange: pageContent['isOnlyTheme'] ?? false,
              animationController: animationController,
              isAuthed: isAuthed,
              setAutentication: () {
                setState(() {
                  isAuthed = true;
                });
              },
              updatePage: _updateBar,
            );
          });
          break;

        default:
        /* setState(() {
            tabBody = WelcomeScreen(
              animationController: animationController,
              updatePage: _updateBar,
            );
          }); */
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => OpacityCubit(),
        ),
        BlocProvider(
          create: (_) => CurrentPlacemarkCubit(),
        ),
        BlocProvider(
          create: (_) => UserPositionCubit(),
        ),
      ],
      child: WillPopScope(
          onWillPop: () async {
            _updateBar(pageId: Lastscreens.returnGoingpage());
            return false;
          },
          child: Container(
            color: AppTheme.background1,
            child: Scaffold(
              key: scaffoldKey,
              drawer: isDrawer
                  ? Drawer(
                      backgroundColor: AppTheme.background,
                      child: Drawers(
                        darkTheme: darkTheme,
                        updatePage: _updateBar,
                      ),
                    )
                  : null,
              bottomNavigationBar: bottombar
                  ? CurvedNavigationBar(
                      index: currIndex,
                      backgroundColor: AppTheme.firstColor.withOpacity(.3),
                      height: AppBar().preferredSize.height,
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
                          default:
                        }
                      },
                    )
                  : null,
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
          )),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
