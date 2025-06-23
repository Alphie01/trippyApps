import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TrippyAlpapp/core/classes/maps.dart';
import 'package:TrippyAlpapp/core/constants/sizeconfig.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:TrippyAlpapp/screens/guide/guideScreen.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:TrippyAlpapp/widgets/box_view.dart';
import 'package:TrippyAlpapp/widgets/textfield.dart';

class DraggableSearchScreen extends StatefulWidget {
  const DraggableSearchScreen({
    super.key,
    this.updatePage,
    this.children,
    this.physics,
  });
  final Function? updatePage;
  final List<Widget>? children;
  final ScrollPhysics? physics;

  @override
  State<DraggableSearchScreen> createState() => _DraggableSearchScreenState();
}

class _DraggableSearchScreenState extends State<DraggableSearchScreen> {
  bool isSearched = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0),
      child: DraggableScrollableSheet(
        initialChildSize: isSearched ? .7 : .3,
        maxChildSize: .9,
        builder: (_, controller) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0),
                ),
              ),
              padding: EdgeInsets.only(
                bottom: getPaddingScreenBottomHeight(),
                top: paddingHorizontal,
              ),
              child: ListView(
                physics: widget.physics ?? AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: paddingZero,
                controller: controller,
                children: [
                  Box_View(
                    boxInside: Row(
                      children: [AppLargeText(text: 'Şimdi Ara')],
                    ),
                  ),
                  Box_View(
                    boxInside: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(text: 'Ara'),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSearched = true;
                            });
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomTextfield(
                                  hintText:
                                      'Aramak istediğiniz anahtar kelimeyi yazınız...',
                                  isLast: true,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.contrastColor1
                                        .withOpacity(.6)),
                                child: FaIcon(
                                  FontAwesomeIcons.search,
                                  color: AppTheme.textColor,
                                  size: 14,
                                ),
                              ),
                              /* ListView.builder(
                                shrinkWrap: true,
                                padding: paddingZero,
                                itemCount: MapsMarker.currentIstasyonList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Istasyon currIstasyon =
                                      MapsMarker.currentIstasyonList[index];
                                  return IstasyonDisplayer(
                                      currIstasyon: currIstasyon);
                                },
                              ), */
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Box_View(
                    boxInside: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(text: 'Yakındaki İstasyonlar'),
                        Container(
                          height: 130,
                          child: ListView.builder(
                            itemCount: MapsMarker.currentIstasyonList.length,
                            scrollDirection: Axis.horizontal,
                            padding: paddingZero,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              Istasyon selected =
                                  MapsMarker.currentIstasyonList[index];
                              return Container(
                                padding: EdgeInsets.only(
                                  top: paddingHorizontal,
                                ),
                                margin:
                                    EdgeInsets.only(right: paddingHorizontal),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: AppTheme.background,
                                          image: DecorationImage(
                                              image: selected
                                                  .istasyonNetworkImage.first),
                                          shape: BoxShape.circle),
                                    ),
                                    Expanded(
                                        child: Container(
                                      child: AppText(text: 'text'),
                                    ))
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
