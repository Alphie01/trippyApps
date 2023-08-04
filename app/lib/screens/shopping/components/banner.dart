import 'package:TrippyAlpapp/constants/sizeConfig.dart';
import 'package:TrippyAlpapp/constants/theme.dart';
import 'package:TrippyAlpapp/widgets/app_large_text.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:flutter/material.dart';

class TopBanner extends StatefulWidget {
  const TopBanner({super.key});

  @override
  State<TopBanner> createState() => _TopBannerState();
}

class _TopBannerState extends State<TopBanner> {
  PageController pageController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 200,
      child: PageView.builder(
        controller: pageController,
        itemCount: 5,
        scrollDirection: Axis.vertical,
        itemBuilder: (ctx, pageIndex) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://images.pexels.com/photos/1001990/pexels-photo-1001990.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Positioned(
                right: 10,
                child: Container(
                  width: 15,
                  alignment: Alignment.center,
                  height: 200,
                  child: ListView.builder(
                    itemCount: 5,
                    physics: NeverScrollableScrollPhysics(),
                    padding: paddingZero,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 15,
                        height: 15,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppTheme.background),
                        child: Container(
                          decoration: BoxDecoration(
                              color: pageIndex >= index
                                  ? AppTheme.firstColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                height: 200,
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(
                    left: paddingHorizontal,
                    right: MediaQuery.of(context).size.width * .2,
                    bottom: paddingHorizontal),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.transparent,
                      AppBlackTheme.background,
                    ],
                  ),
                ),
                child: Container(
                  child: AppText(
                    text: 'Banner_Exp',
                    color: AppBlackTheme.textColor,
                    size: 22,
                    maxLineCount: 2,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
