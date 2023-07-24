import 'package:app/constants/sizeConfig.dart';
import 'package:app/constants/theme.dart';
import 'package:app/widgets/app_large_text.dart';
import 'package:app/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  final AnimationController? animationController;
  final Function updatePage;
  const LoadingScreen(
      {Key? key, this.animationController, required this.updatePage})
      : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  int index = 0;
  List<String> content = [
    'anana',
    'deneme',
    'dfalfaplpfa',
  ];
  AnimationController? _animationController;
  Animation<double>? _breathAnimation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);
    _breathAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController!);

    animationBreath();
    // TODO: implement initState
    super.initState();
    widget.animationController!.forward();
  }

  void animationBreath() {
    print('object');
    _animationController!.forward();
    Future.delayed(Duration(seconds: 2), () {
      widget.updatePage(pageId: 0);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(
          top: getPaddingSreenTopHeight(),
          bottom: getPaddingSreenBottomHeight()),
      color: AppTheme.firstColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AppLargeText(text: 'Logo_'),
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
              AnimatedBuilder(
                animation: _animationController!,
                builder: (BuildContext context, Widget? child) {
                  return Opacity(
                    opacity: _breathAnimation!.value,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: paddingHorizontal),
                      child: AppText(
                        text:
                            'Kullanıcı Isim, Senin İçin Son Hazırlıkları Tamamlıyoruz!',
                        align: TextAlign.center,
                        size: 22,
                        color: AppTheme.background,
                      ),
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
