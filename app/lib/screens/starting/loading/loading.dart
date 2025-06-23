import 'package:TrippyAlpapp/core/classes/bloc/maps_cubit.dart';
import 'package:TrippyAlpapp/core/classes/permissions.dart';
import 'package:TrippyAlpapp/core/classes/user.dart';
import 'package:TrippyAlpapp/core/constants/sizeconfig.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/core/sharedPref/sharedpreferences.dart';
import 'package:TrippyAlpapp/core/sharedPref/sharedprefkeynames.dart';
import 'package:TrippyAlpapp/screens/starting/loading/components/logoContainer.dart';
import 'package:TrippyAlpapp/screens/starting/mail_comfimataion.dart';
import 'package:TrippyAlpapp/screens/starting/register/register.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:TrippyAlpapp/widgets/box_view.dart';
import 'package:TrippyAlpapp/widgets/networkImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:local_auth/local_auth.dart';

class LoadingScreen extends StatefulWidget {
  final AnimationController? animationController;
  final bool isAuthed, isOnlyThemeChange;
  final Function setAutentication;
  final Function updatePage;

  const LoadingScreen(
      {Key? key,
      this.animationController,
      required this.isOnlyThemeChange,
      required this.updatePage,
      required this.isAuthed,
      required this.setAutentication})
      : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  int? selectedIndex;
  bool selectShop = false,
      waitFetch = false,
      _isSupportedAuth = false,
      isLoading = true,
      _authFailed = false;
  LocalAuthentication localAuthentication = LocalAuthentication();
  int initPage = 0;
  bool approved = false;
  PageController? pageController;
  AnimationController? _animationController;
  Animation<double>? _breathAnimation;

  @override
  void initState() {
    localAuthentication.isDeviceSupported().then((bool isSupported) {
      setState(() {
        _isSupportedAuth = isSupported;
      });
    });
    initiliazeApp();
    setState(() {
      pageController = PageController(initialPage: initPage);
    });
    /* _getBiometric(); */

    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);
    _breathAnimation =
        Tween<double>(begin: 1, end: 0).animate(_animationController!);

    super.initState();
    widget.animationController!.forward();
  }

  Future<void> initiliazeApp() async {
    if (User.biometrics) {
      if (!widget.isAuthed) {
        bool biometricOkay = await _authenticate();
        if (biometricOkay) {
          widget.setAutentication();
          loginWithToken(SharedPref.getStringValuesSF(userToken));
        }
      } else {
        loginWithToken(SharedPref.getStringValuesSF(userToken));
      }
    } else {
      loginWithToken(SharedPref.getStringValuesSF(userToken));
      /*  if (Shop.isSelectedShop()) {
        widget.updatePage(pageId: 0);
      } else {
        setState(
          () {
            selectShop = true;
          },
        );
      } */
    }
  }

  void statusChange() {
    User.userProfile!.userStatus = UserStatus.approved;
    setState(() {
      approved = false;
    });
  }

  Future<bool> _authenticate() async {
    try {
      bool authenticated = await localAuthentication.authenticate(
          localizedReason:
              'İşletmenizin Güvenliği İçin Kendinizi Tanıtmalısınız!',
          options: const AuthenticationOptions(
              stickyAuth: true, biometricOnly: false));

      return authenticated;
    } on PlatformException catch (e) {
      setState(() {
        _authFailed = true;
      });
      print('error' + e.toString());
      return true;
    }
  }

  Future loginWithToken(String token) async {
    setState(() {
      isLoading = false;
    });
    bool dance = await User.fetchUserbyToken(token);
    if (dance) {
      getCurrentPosition();
      widget.updatePage(pageId: 0);
    } else {
      SharedPref.removeStrValue(userToken);
      widget.updatePage(pageId: 92);
    }
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await Permissions.handleLocationPermission(context);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      context.read<UserPositionCubit>().setPosition(position);
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  Future<void> _getBiometric() async {
    List<BiometricType> _listBiometric =
        await localAuthentication.getAvailableBiometrics();

    if (!mounted) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(
          top: getPaddingScreenTopHeight(),
          bottom: getPaddingScreenBottomHeight()),
      color: AppTheme.firstColor,
      child: User.userProfile != null
          ? User.userProfile!.userStatus == UserStatus.notApproved || approved
              ? GSOP_Mail_Comfirmation(fetchedMap: {
                  'kullanici_mail': User.userProfile!.userMail,
                  'kullanici_secretToken': User.userProfile!.token,
                }, updatePage: statusChange)
              : selectShop
                  ? isLoading
                      ? Container()
                      : Center(
                          child: Container(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )
                  : _authFailed
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Logo(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: paddingHorizontal * 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: AppText(
                                      text:
                                          'Kendinizi Tanıtma İşlemi Tamamlanmamıştır!',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _authFailed = !_authFailed;
                                      });
                                      initiliazeApp();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: paddingHorizontal),
                                      padding:
                                          EdgeInsets.all(paddingHorizontal),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius: defaultRadius),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppText(
                                            text: 'Tekrar Tanıt',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                          FaIcon(
                                            FontAwesomeIcons.lock,
                                            size: 14,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      SharedPref.removeStrValue(userToken);
                                      widget.updatePage(pageId: 92);
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(paddingHorizontal),
                                      decoration: BoxDecoration(
                                          color: AppTheme.alertRed[0],
                                          border: Border.all(
                                              color: AppTheme.alertRed[0]),
                                          borderRadius: defaultRadius),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppText(
                                            text: 'Çıkış Yap',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                          FaIcon(
                                            FontAwesomeIcons.x,
                                            size: 14,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      : WaitingRoom()
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Logo(),
                Padding(
                  padding: EdgeInsets.only(bottom: paddingHorizontal),
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class WaitingRoom extends StatelessWidget {
  const WaitingRoom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Logo(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(bottom: 50),
              child: CircularProgressIndicator(
                color: AppTheme.background,
              ),
            ),
            Container(
              child: AppText(
                text: 'İşletmenizin Güvenliği İçin Kendinizi Tanıtmalısınız!',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                size: 14,
              ),
            ),
          ],
        )
      ],
    );
  }
}
