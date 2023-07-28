import 'package:TrippyAlpapp/constants/sizeConfig.dart';
import 'package:TrippyAlpapp/constants/theme.dart';
import 'package:TrippyAlpapp/widgets/app_large_text.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapsModalPage extends StatefulWidget {
  const MapsModalPage({super.key, required this.closeNavigator});
  final Function closeNavigator;
  @override
  State<MapsModalPage> createState() => _MapsModalPageState();
}

class _MapsModalPageState extends State<MapsModalPage> {
  TextEditingController _editingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  bool showRecentSearchs = false;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset < 0) {
        Navigator.pop(context);
      }
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          showRecentSearchs = true;
        });
      } else {
        setState(() {
          showRecentSearchs = false;
        });
      }
    });

    // TODO: implement initState
    super.initState();
  }

  void _handleTapOutside(BuildContext context) {
    // TextField focusunu kaldır.
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        height: SizeConfig.screenHeight,
        color: AppTheme.background,
        padding: EdgeInsets.only(
          top: getPaddingSreenTopHeight(),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: paddingHorizontal, right: paddingHorizontal, top: 75),
              child: GestureDetector(
                onTap: () {
                  _handleTapOutside(context);
                },
                child: ListView(
                  shrinkWrap: true,
                  padding: paddingZero,
                  /* physics: NeverScrollableScrollPhysics(), */
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppLargeText(
                                text: 'Bu Gün',
                                maxLineCount: 4,
                                size: 54,
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 15),
                                  height: 5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color:
                                          AppTheme.firstColor.withOpacity(.6)),
                                ),
                              )
                            ],
                          ),
                          AppLargeText(
                            text: 'Ne Yapmak',
                            maxLineCount: 4,
                            size: 54,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 15),
                                  height: 5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color:
                                          AppTheme.firstColor.withOpacity(.6)),
                                ),
                              ),
                              AppLargeText(
                                align: TextAlign.right,
                                text: 'İstersin?',
                                maxLineCount: 4,
                                size: 54,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: paddingHorizontal),
                      decoration: BoxDecoration(
                        color: AppTheme.background,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.firstColor.withOpacity(.3),
                            blurRadius: 5.0, // soften the shadow
                            spreadRadius: 0.0, //extend the shadow
                            offset: Offset(
                              0.0,
                              8.0, // Move to bottom 5 Vertically
                            ), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _editingController,
                        onChanged: (news) {},
                        focusNode: _focusNode,
                        style:
                            TextStyle(fontSize: 16, color: AppTheme.textColor),
                        cursorColor: AppTheme.textColor,
                        decoration: InputDecoration(
                          hintText: "Aramak için ....",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          fillColor: AppTheme.background,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.firstColor.withOpacity(.3)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppTheme.firstColor.withOpacity(.6)),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                    showRecentSearchs
                        ? Column(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.rotate,
                                              color: AppTheme.textColor,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 15),
                                              child: AppText(
                                                  text: 'searced_${index}'),
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
                          )
                        : Container(
                            margin: EdgeInsets.only(
                                top: paddingHorizontal,
                                bottom: getPaddingSreenBottomHeight()),
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 6,
                              itemBuilder: (ctx, index) {
                                return Container(
                                  /* margin: index == 0 || index == 6
                                      ? EdgeInsets.only(top: 15)
                                      : paddingZero, */
                                  margin: EdgeInsets.only(top: 15),
                                  child: index % 2 == 0
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 7.5),
                                                height: 300,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 7.5),
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                      color: Colors.pink,
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      15)),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 7.5),
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              bottom: Radius
                                                                  .circular(
                                                                      15)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 7.5),
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                      color: Colors.pink,
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      15)),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 7.5),
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              bottom: Radius
                                                                  .circular(
                                                                      15)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 7.5),
                                                height: 300,
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              decoration: BoxDecoration(
                  color: AppTheme.background,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.firstColor.withOpacity(.3),
                      blurRadius: 5.0, // soften the shadow
                      spreadRadius: 0.0, //extend the shadow
                      offset: Offset(
                        0.0,
                        8.0, // Move to bottom 5 Vertically
                      ), // changes position of shadow
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  GestureDetector(
                    onTap: () {
                      widget.closeNavigator();
                    },
                    child: FaIcon(FontAwesomeIcons.xmark),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
