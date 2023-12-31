import 'package:TrippyAlpapp/constants/sizeConfig.dart';
/* import 'package:TrippyAlpapp/constants/stringConstans.dart'; */
import 'package:TrippyAlpapp/constants/theme.dart';
import 'package:TrippyAlpapp/core/classes/shopping/userLastProducts.dart';
import 'package:TrippyAlpapp/core/shoppingCart.dart';
import 'package:TrippyAlpapp/globals/users.dart';
import 'package:TrippyAlpapp/screens/shopping/components/banner.dart';
import 'package:TrippyAlpapp/screens/shopping/components/categoryGridview.dart';
import 'package:TrippyAlpapp/screens/shopping/components/productCardview.dart';
import 'package:TrippyAlpapp/screens/socialMedia/component/classes/post.dart';
import 'package:TrippyAlpapp/screens/socialMedia/component/classes/story.dart';
import 'package:TrippyAlpapp/widgets/app_large_text.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class ShoppingScreen extends StatefulWidget {
  final Function? updatePage;
  const ShoppingScreen(
      {Key? key,
      this.animationController,
      this.updatePage,
      required this.scaffoldKey})
      : super(key: key);
  final AnimationController? animationController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  PostClasses postClasses = PostClasses(
      postBelongs: User.userProfile, postString: 'deneme String Caption');

  bool isTopRefresh = false, refreshData = false;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    super.initState();
    widget.animationController!.forward();
    scrollController.addListener(scrollEvent);
  }

  void scrollEvent() {
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
          child: Stack(
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
                        padding: EdgeInsets.only(
                          top: getPaddingSreenTopHeight() + 10,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height -
                              getPaddingSreenBottomHeight() * 2,
                          margin: EdgeInsets.only(
                              left: paddingHorizontal,
                              right: paddingHorizontal,
                              top: getPaddingSreenTopHeight()),
                          child: ListView(
                            padding: EdgeInsets.only(
                                bottom: 15, top: AppBar().preferredSize.height),
                            children: [
                              TopBanner(),
                              Container(
                                padding: EdgeInsets.only(
                                  top: paddingHorizontal,
                                ),
                                child: AppText(
                                  text: 'Kategoriler',
                                  size: 22,
                                ),
                              ),
                              CategoryGridview(),
                              UserLastProducts.returnList().length != 0
                                  ? Container(
                                      padding: EdgeInsets.only(
                                        top: paddingHorizontal,
                                        bottom: paddingHorizontal,
                                      ),
                                      child: AppText(
                                        text: 'Daha Önce Baktıklarınız',
                                        size: 22,
                                      ),
                                    )
                                  : Container(),
                              UserLastProducts.returnList().length != 0 ? Container(
                                height:
                                    MediaQuery.of(context).size.height * .25,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      UserLastProducts.returnList().length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .33,
                                      width: MediaQuery.of(context).size.width *
                                          .33,
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                    );
                                  },
                                ),
                              ): Container(),
                              Container(
                                padding: EdgeInsets.only(
                                  top: paddingHorizontal,
                                  bottom: paddingHorizontal,
                                ),
                                child: AppText(
                                  text: 'Sizin İçin Önerilenler',
                                  size: 22,
                                ),
                              ),
                              ProductGrid(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              getAppBarUI(),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
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
                      bottom: 20),
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
                          FontAwesomeIcons.shoppingBag,
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
