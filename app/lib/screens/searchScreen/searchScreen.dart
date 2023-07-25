import 'package:app/constants/sizeConfig.dart';
/* import 'package:app/constants/stringConstans.dart'; */
import 'package:app/constants/theme.dart';
import 'package:app/globals/users.dart';
import 'package:app/screens/socialMedia/component/classes/post.dart';
import 'package:app/screens/socialMedia/component/classes/story.dart';
import 'package:app/widgets/app_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final Function? updatePage;
  const SearchScreen(
      {Key? key,
      this.animationController,
      this.updatePage,
      required this.scaffoldKey})
      : super(key: key);
  final AnimationController? animationController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  PostClasses postClasses = PostClasses(
      postBelongs: User.userProfile, postString: 'deneme String Caption');

  bool isTopRefresh = false, refreshData = false;
  List categories = [
    'Tümü',
    'Kişiler',
    'Şehirler',
    'Seyahat Rotaları',
    'Mekanlar',
    'Alışveriş',
  ];

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

    if (scrollController.offset < getPaddingSreenTopHeight()) {
      
    }
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
                        child: ListView(
                          shrinkWrap: true,
                          padding:
                              EdgeInsets.only(top: getPaddingSreenTopHeight()),
                          controller: scrollController,
                          children: [
                            isTopRefresh
                                ? Container(
                                    width: double.maxFinite,
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
                            Container(
                              width: double.maxFinite,
                              height: 100,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                itemBuilder: (ctx, index) {
                                  return Container(
                                    height: 100,
                                    margin: index == 0
                                        ? EdgeInsets.symmetric(
                                            horizontal: paddingHorizontal)
                                        : EdgeInsets.only(
                                            right: paddingHorizontal),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: paddingHorizontal * 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: AppTheme.firstColor
                                            .withOpacity(.1)),
                                    child:
                                        AppText(text: '${categories[index]}'),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: ListView.builder(
                                itemCount: 6,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, ind) {
                                  if (ind % 2 == 0) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .66,
                                            color: Colors.amber,
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .33,
                                                color: Colors.pink,
                                              ),
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .33,
                                                color: Colors.green,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .33,
                                                color: Colors.blue,
                                              ),
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .33,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .33,
                                                color: Colors.orange,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .33,
                                                color: Colors.greenAccent,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .33,
                                                color: Colors.pinkAccent,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .33,
                                                color: Colors.pink,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .33,
                                                color: Colors.green,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .33,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .33,
                                                    color: Colors.pink,
                                                  ),
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .33,
                                                    color: Colors.green,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .33,
                                                    color: Colors.blue,
                                                  ),
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .33,
                                                    color: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .66,
                                                color: Colors.amber,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            )
                          ],
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
                          FontAwesomeIcons.search,
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
