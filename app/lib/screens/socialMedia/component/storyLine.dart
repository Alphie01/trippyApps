import 'package:TrippyAlpapp/constants/sizeConfig.dart';
import 'package:TrippyAlpapp/constants/theme.dart';
import 'package:TrippyAlpapp/screens/socialMedia/component/classes/story.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class StoryLine extends StatefulWidget {
  StoryLine({super.key, required this.storyList});
  List<Story> storyList;

  @override
  State<StoryLine> createState() => _StoryLineState();
}

class _StoryLineState extends State<StoryLine> with TickerProviderStateMixin {
  AnimationController? animationController;
  int currIndex = -1;

  bool changeStory = false;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        if (animationController!.isCompleted) {
          widget.storyList[currIndex].seen = true;
          if (currIndex != widget.storyList.length - 1) {
            setState(() {
              changeStory = true;
              currIndex++;
            });
            print(changeStory);
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                changeStory = false;
              });
              animationController!.repeat();
              animationController!.forward();
              print(changeStory);
            });
          } else {
            Navigator.pop(context);
          }
        }
      });

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: getPaddingSreenTopHeight() + AppBar().preferredSize.height,
      ),
      width: double.maxFinite,
      alignment: Alignment.center,
      height: 100,
      child: ListView.builder(
        itemCount: widget.storyList.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: paddingZero,
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                currIndex = index;
              });

              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (ctx) {
                  animationController!.repeat();
                  animationController!.forward();

                  return GestureDetector(
                    onLongPressStart: (details) {
                      animationController!.stop();
                    },
                    onLongPressEnd: (details) {
                      animationController!.forward();
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black,
                      child: changeStory
                          ? Container(
                              width: double.maxFinite,
                              height: MediaQuery.of(context).size.height,
                              color: Colors.black,
                            )
                          : Stack(
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: widget
                                            .storyList[currIndex].storyPhoto,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Container(
                                  width: double.maxFinite,
                                  height: MediaQuery.of(context).size.height,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            print('önceki');
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            print('sonraki');
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: getPaddingSreenTopHeight(),
                                      left: paddingHorizontal,
                                      bottom: getPaddingSreenBottomHeight(),
                                      right: paddingHorizontal),
                                  width: double.maxFinite,
                                  height: MediaQuery.of(context).size.height,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          AnimatedBuilder(
                                            animation: animationController!,
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 15),
                                                child: LinearProgressIndicator(
                                                  value: animationController!
                                                      .value,
                                                  color: Colors.white,
                                                  backgroundColor: Colors.white
                                                      .withOpacity(.3),
                                                ),
                                              );
                                            },
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 35,
                                                    height: 35,
                                                    margin: EdgeInsets.only(
                                                        right: 15),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Colors.black),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      AppText(
                                                        text:
                                                            '${widget.storyList[currIndex].userName}',
                                                        size: 18,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 10),
                                                            child: FaIcon(
                                                              FontAwesomeIcons
                                                                  .paperPlane,
                                                              size: 12,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          AppText(
                                                            text:
                                                                'Rotayı Görüntüle',
                                                            size: 12,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      child: FaIcon(
                                                    FontAwesomeIcons
                                                        .ellipsisVertical,
                                                    color: Colors.white,
                                                  )),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: 15),
                                                      child: FaIcon(
                                                        FontAwesomeIcons.xmark,
                                                        color: Colors.white,
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (ctx) {
                                                return Container(
                                                  width: double.maxFinite,
                                                  color: Colors.white,
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                );
                                              });
                                        },
                                        child: Container(
                                          width: double.maxFinite,
                                          height: 15,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ),
                  );
                },
              );
            },
            child: Container(
              margin: index == 0
                  ? EdgeInsets.only(
                      left: 25,
                      right: 5,
                    )
                  : EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: widget.storyList[index].seen
                          ? AppTheme.firstColor.withOpacity(.1)
                          : AppTheme.firstColor,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 6),
                    width: 70,
                    child: AppText(
                      text: widget.storyList[index].userName,
                      align: TextAlign.center,
                      maxLineCount: 1,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
