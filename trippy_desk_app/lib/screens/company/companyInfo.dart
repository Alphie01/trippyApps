import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:trippy_desk_app/constants/sizeConfig.dart';
import 'package:trippy_desk_app/constants/theme.dart';
import 'package:trippy_desk_app/widgets/app_text.dart';

class BusinessInfo extends StatefulWidget {
  final Function? updatePage;
  const BusinessInfo(
      {Key? key,
      this.animationController,
      this.updatePage,
      required this.scaffoldKey})
      : super(key: key);
  final AnimationController? animationController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  _BusinessInfoState createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  AnimationController? appBarController;
  Animation<double>? appbarAnimation;

  bool isTopRefresh = false, refreshData = false;
  PageController pageController = PageController(initialPage: 1);

  double scrollOffset = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    super.initState();

    appBarController =
        AnimationController(vsync: this, duration: defaultDuration);
    appbarAnimation =
        Tween<double>(begin: 0, end: -100).animate(appBarController!);

    widget.animationController!.forward();
    scrollController.addListener(scrollEvent);
  }

  void scrollEvent() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      // Kullanıcı aşağı kaydırıyor

      appBarController!.reverse();
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      // Kullanıcı yukarı kaydırıyor
      appBarController!.forward();
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      print('bottom Last Point ');
      //TODO yeni data yükenicek
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      print('top Last Point');
      setState(() {
        isTopRefresh = true;
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isTopRefresh = false;
        });
      });
      //TODO refresh Point
    }

    if (scrollController.offset < getPaddingSreenTopHeight()) {}
  }

  void dataUpdate() {
    setState(() {
      refreshData = true;
    });
    Future.delayed(
      Duration(microseconds: 50),
      () {
        setState(
          () {
            refreshData = false;
          },
        );
      },
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onPanUpdate: (details) {},
          child: PageView(
            controller: pageController,
            children: [
              Container(),
              Stack(
                children: <Widget>[
                  AnimatedBuilder(
                    animation: widget.animationController!,
                    builder: (BuildContext context, Widget? child) {
                      return FadeTransition(
                        opacity: topBarAnimation!,
                        child: Transform(
                          transform: Matrix4.translationValues(
                              0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                          child: Container(
                            width: double.maxFinite,
                            height: MediaQuery.of(context).size.height,
                            child: ListView(
                              shrinkWrap: true,
                              padding: paddingZero,
                              children: [
                                Container(
                                  
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  isTopRefresh
                      ? Container(
                          width: double.maxFinite,
                          height: 80,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          child: Container(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                              color: AppTheme.firstColor,
                            ),
                          ),
                        )
                      : Container(),
                  AnimatedBuilder(
                    animation: appBarController!,
                    builder: (BuildContext context, Widget? child) {
                      return Transform.translate(
                        offset: Offset(0, appbarAnimation!.value),
                        child: getAppBarUI(),
                      );
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  )
                ],
              ),
              Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: AppTheme.background,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.textColor.withOpacity(topBarOpacity),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(
                      top: getPaddingSreenTopHeight(),
                      left: paddingHorizontal,
                      right: paddingHorizontal,
                      bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.scaffoldKey.currentState!.openDrawer();
                            },
                            child: FaIcon(
                              FontAwesomeIcons.bars,
                              color: AppTheme.textColor,
                              size: 20,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: AppText(
                              text: 'Logo_',
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        /* onTap: () {
                          SharedPref.addBoolToSF(darkOrLightMode, false);
                        }, */
                        child: FaIcon(
                          FontAwesomeIcons.message,
                          color: AppTheme.textColor,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
