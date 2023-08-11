import 'dart:ui';
import 'package:TrippyAlpapp/constants/sizeConfig.dart';
import 'package:TrippyAlpapp/constants/theme.dart';
import 'package:TrippyAlpapp/globals/users.dart';
import 'package:TrippyAlpapp/screens/searchScreen/components/classes/categories.dart';
import 'package:TrippyAlpapp/screens/searchScreen/components/search_city_page.dart';
import 'package:TrippyAlpapp/screens/socialMedia/component/classes/post.dart';
import 'package:TrippyAlpapp/widgets/app_large_text.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen(
      {Key? key,
      this.animationController,
      this.updatePage,
      required this.scaffoldKey})
      : super(key: key);

  final AnimationController? animationController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function? updatePage;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  List<SearchCategory> categories = [
    SearchCategory(
        categoryName: 'Tümü',
        categoryAssetImg: AssetImage('assets/search/search_1.jpg')),
    SearchCategory(
        categoryName: 'Keşfet',
        categoryAssetImg: AssetImage('assets/search/search_2.jpg')),
    SearchCategory(
        categoryName: 'Şehirler',
        categoryAssetImg: AssetImage('assets/search/search_3.jpg'),
        categoryOnclickFunc: () {}),
    SearchCategory(
        categoryName: 'Seyahat Rotaları',
        categoryAssetImg: AssetImage('assets/search/search_4.jpg')),
    SearchCategory(
        categoryName: 'Restorant',
        categoryAssetImg: AssetImage('assets/search/search_5.jpg')),
    SearchCategory(
        categoryName: 'Bar',
        categoryAssetImg: AssetImage('assets/search/search_7.jpg')),
    SearchCategory(
        categoryName: 'Gece Hayatı',
        categoryAssetImg: AssetImage('assets/search/search_8.jpg')),
    SearchCategory(
        categoryName: 'Sağlık',
        categoryAssetImg: AssetImage('assets/search/search_9.jpg')),
    SearchCategory(
        categoryName: 'Alışveriş',
        categoryAssetImg: AssetImage('assets/search/search_6.jpg')),
  ];

  bool isSelectedCategory = false;
  bool isTopRefresh = false, refreshData = false;
   


  final ScrollController scrollController = ScrollController();
  bool showRecentSearchs = false, showFilters = false, showAppbar = false;
  Animation<double>? topBarAnimation;
  double topBarOpacity = 0.0, searchBarOpacity = .6;
  PageController? pageController;

  TextEditingController _editingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  AnimationController? filterAnimation;
  Animation<double>? filterOpacity, filterTransform;

  Widget tabBody = Container();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          searchBarOpacity = 1.0;
          showRecentSearchs = true;
        });
      } else {
        setState(() {
          searchBarOpacity = .6;
          showRecentSearchs = false;
        });
      }
    });

    pageController = PageController();


    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    filterAnimation =
        AnimationController(vsync: this, duration: defaultDuration);
    filterOpacity =
        Tween<double>(begin: 0.0, end: 1.0).animate(filterAnimation!);
    filterTransform =
        Tween<double>(begin: 150.0, end: 0.0).animate(filterAnimation!);

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
                  height: AppBar().preferredSize.height,
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
                        onTap: () {
                          filterAnimation!.reverse().then((value) {
                            setState(() {
                              showFilters = false;
                            });
                          });
                        },
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

  void _handleTapOutside(BuildContext context) {
    // TextField focusunu kaldır.
    _focusNode.unfocus();
    filterAnimation!.reverse();
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
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              AnimatedBuilder(
                animation: widget.animationController!,
                builder: (BuildContext context, Widget? child) {
                  return FadeTransition(
                    opacity: topBarAnimation!,
                    child: Transform(
                      transform: Matrix4.translationValues(
                          0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                      child: PageView(
                        controller: pageController!,
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: MediaQuery.of(context).size.height,
                            padding: EdgeInsets.only(
                              top: 2 * getPaddingSreenTopHeight() + 15,
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(
                                  top: getPaddingSreenTopHeight()),
                              controller: scrollController,
                              children: [
                                isTopRefresh
                                    ? Container(
                                        width: double.maxFinite,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 15),
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
                                GestureDetector(
                                  onTap: () {
                                    _handleTapOutside(context);
                                  },
                                  child: isSelectedCategory
                                      ? Container()
                                      : Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: paddingHorizontal),
                                          child: ListView(
                                            shrinkWrap: true,
                                            padding: paddingZero,
                                            children: [
                                              AppLargeText(
                                                  text:
                                                      'Hangi Kategoride Aramak İstiyorsunuz?'),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: paddingHorizontal),
                                                decoration: BoxDecoration(
                                                  color: AppTheme.background,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                      color: AppTheme.firstColor
                                                          .withOpacity(
                                                              searchBarOpacity)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppTheme.firstColor
                                                          .withOpacity(.3),
                                                      blurRadius:
                                                          5.0, // soften the shadow
                                                      spreadRadius:
                                                          0.0, //extend the shadow
                                                      offset: Offset(
                                                        0.0,
                                                        8.0, // Move to bottom 5 Vertically
                                                      ), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 9,
                                                      child: TextField(
                                                        controller:
                                                            _editingController,
                                                        onChanged: (news) {},
                                                        focusNode: _focusNode,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: AppTheme
                                                                .textColor),
                                                        cursorColor:
                                                            AppTheme.textColor,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Aramak için ....",
                                                          hintStyle: TextStyle(
                                                              color: Colors.grey
                                                                  .shade500),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none),
                                                          fillColor: AppTheme
                                                              .background,
                                                          filled: true,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          showFilters = true;
                                                        });
                                                        filterAnimation!
                                                            .forward();
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: FaIcon(
                                                          FontAwesomeIcons
                                                              .filter,
                                                          color: AppTheme
                                                              .textColor,
                                                          size: 22,
                                                        ),
                                                      ),
                                                    ))
                                                  ],
                                                ),
                                              ),
                                              if (showRecentSearchs)
                                                recentSearchs()
                                              else
                                                Container()
                                            ],
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          SearchCityPage()
                        ],
                      ),
                    ),
                  );
                },
              ),
              showFilters
                  ? AnimatedBuilder(
                      animation: filterAnimation!,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, filterTransform!.value),
                          child: Opacity(
                            opacity: filterOpacity!.value,
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              width: double.maxFinite,
                              height: MediaQuery.of(context).size.height / 2,
                              margin: EdgeInsets.only(
                                top: getPaddingSreenTopHeight() * 2,
                              ),
                              child: GetSearchCategoriesWidget(
                                  onTap: (String value) {},
                                  categories: categories),
                            ),
                          ),
                        );
                      },
                    )
                  : Container(),
              showAppbar ? getAppBarUI() : Container(),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }

  Column recentSearchs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: paddingHorizontal),
          child: AppText(
            text: 'Daha Önce Aradıkların',
            fontWeight: FontWeight.w600,
          ),
        ),
        ListView.builder(
          itemCount: 5,
          physics: NeverScrollableScrollPhysics(),
          padding: paddingZero,
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.rotate,
                        color: AppTheme.textColor,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: AppText(text: 'searced_${index}'),
                      )
                    ],
                  ),
                  FaIcon(
                    FontAwesomeIcons.xmark,
                    color: AppTheme.textColor,
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}

class GetSearchCategoriesWidget extends StatelessWidget {
  const GetSearchCategoriesWidget({
    super.key,
    required this.categories,
    this.onTap,
  });

  final List<SearchCategory> categories;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    int index = 0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          color: AppTheme.firstColor.withOpacity(.3),
          borderRadius: BorderRadius.circular(15)),
      child: ListView(
        padding: paddingZero,
        children: [
          Row(
            children: [
              Expanded(
                child: SearchSelectBox(
                  categories: categories[index],
                  height: MediaQuery.of(context).size.height / 3,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    SearchSelectBox(
                      categories: categories[index + 1],
                      height: MediaQuery.of(context).size.height / 6,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15)),
                    ),
                    SearchSelectBox(
                      categories: categories[index + 2],
                      height: MediaQuery.of(context).size.height / 6,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(15)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  child: SearchSelectBox(
                    categories: categories[index + 3],
                    height: MediaQuery.of(context).size.width / 3 - 15,
                    borderRadius: BorderRadius.circular(15),
                    textSize: 16,
                  ),
                ),
                Expanded(
                  child: SearchSelectBox(
                    categories: categories[index + 4],
                    height: MediaQuery.of(context).size.width / 3 - 15,
                    borderRadius: BorderRadius.circular(15),
                    textSize: 16,
                  ),
                ),
                Expanded(
                  child: SearchSelectBox(
                    categories: categories[index + 5],
                    height: MediaQuery.of(context).size.width / 3 - 15,
                    borderRadius: BorderRadius.circular(15),
                    textSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  child: SearchSelectBox(
                    categories: categories[index + 6],
                    height: MediaQuery.of(context).size.width / 3 - 15,
                    borderRadius: BorderRadius.circular(15),
                    textSize: 16,
                  ),
                ),
                Expanded(
                  child: SearchSelectBox(
                    categories: categories[index + 7],
                    height: MediaQuery.of(context).size.width / 3 - 15,
                    borderRadius: BorderRadius.circular(15),
                    textSize: 16,
                  ),
                ),
                Expanded(
                  child: SearchSelectBox(
                    categories: categories[index + 8],
                    height: MediaQuery.of(context).size.width / 3 - 15,
                    borderRadius: BorderRadius.circular(15),
                    textSize: 16,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SearchSelectBox extends StatelessWidget {
  const SearchSelectBox({
    super.key,
    required this.categories,
    required this.height,
    required this.borderRadius,
    this.textSize = 22,
  });

  final SearchCategory categories;
  final double height;
  final double textSize;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.5),
      height: height,
      decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: categories.categoryAssetImg,
            fit: BoxFit.cover,
          ),
          borderRadius: borderRadius),
      child: Container(
        color: AppBlackTheme.background.withOpacity(.5),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 0,
              sigmaY: 0,
            ),
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(15),
              child: AppText(
                align: TextAlign.right,
                text: categories.categoryName,
                color: AppBlackTheme.textColor,
                size: textSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
