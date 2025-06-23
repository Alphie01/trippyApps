import 'package:TrippyAlpapp/core/constants/sizeconfig.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/widgets/box_view.dart';
import 'package:TrippyAlpapp/widgets/headerWidget.dart';
import 'package:TrippyAlpapp/widgets/refresh_widget.dart';
import 'package:flutter/material.dart';

class BarsScreen extends StatefulWidget {
  const BarsScreen(
      {Key? key,
      this.animationController,
      this.updatePage,
      required this.scaffoldKey,
      })
      : super(key: key);

  final AnimationController? animationController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function? updatePage;

  @override
  _BarsScreenState createState() => _BarsScreenState();
}

class _BarsScreenState extends State<BarsScreen> with TickerProviderStateMixin {
  bool isSelectedCategory = false;
  bool isTopRefresh = false, refreshData = false;

  final ScrollController scrollController = ScrollController();
  bool showRecentSearchs = false, showFilters = false, showAppbar = false;
  Animation<double>? topBarAnimation;
  double topBarOpacity = 0.0, searchBarOpacity = .6, offset = 0;

  //⁡⁣⁣⁢top Header Animations⁡
  AnimationController? filterAnimation, headerAnimationController;
  Animation<double>? filterOpacity, filterTransform, headerAnimation;
  Color iconColor = AppTheme.textColor;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    headerAnimationController =
        AnimationController(vsync: this, duration: defaultDuration);

    headerAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(headerAnimationController!);

    super.initState();
    widget.animationController!.forward();
    scrollController.addListener(() {
      setState(() {
        offset = scrollController.offset;
      });
      if (scrollController.offset > 60) {
        setState(() {
          iconColor = AppTheme.textColor;
        });
        headerAnimationController!.forward();
      } else {
        setState(() {
          iconColor = Colors.white;
        });
        headerAnimationController!.reverse();
      }
    });
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
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(
                  top: getPaddingScreenTopHeight(),
                ),
                children: [
                  Box_View(
                    boxInside: Column(),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              ),
              Refresh_widget(
                scrollOffset: offset,
                refreshPage: () {},
              ),
              HeaderWidget(
                headerColor: AppTheme.background.withOpacity(.3),
                blurOpacity: headerAnimation!.value,
                headerIconColor: AppTheme.textColor.withOpacity(1),
                scaffoldKey: widget.scaffoldKey,
                updatePage: widget.updatePage!,
              )
            ],
          ),
        ),
      ),
    );
  }
}
