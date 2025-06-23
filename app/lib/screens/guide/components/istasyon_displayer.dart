import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TrippyAlpapp/core/classes/maps.dart';
import 'package:TrippyAlpapp/core/constants/sizeconfig.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/screens/guide/components/classes/crowded_graph.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:TrippyAlpapp/widgets/box_view.dart';
import 'package:TrippyAlpapp/widgets/networkImage.dart';
import 'package:TrippyAlpapp/widgets/textfield.dart';

class IstasyonInfo extends StatelessWidget {
  const IstasyonInfo({
    super.key,
    required this.istasyon,
    this.setRoute,
  });

  final Istasyon istasyon;
  final Function? setRoute;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        DraggableScrollableSheet(
          initialChildSize: .5,
          maxChildSize: .9,
          builder: (_, controller) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: AppTheme.background,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(paddingHorizontal),
                  ),
                ),
                padding: EdgeInsets.only(
                  bottom: getPaddingScreenBottomHeight(),
                ),
                child: ListView(
                  shrinkWrap: true,
                  padding: paddingZero,
                  controller: controller,
                  children: [
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(paddingHorizontal),
                        ),
                      ),
                      child: NetworkContainer(
                                                onLoad: (){},

                        imageUrl: istasyon.istasyonNetworkImage.first,
                        child: Container(
                          padding: EdgeInsets.all(paddingHorizontal),
                          color: Colors.black.withOpacity(.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => setRoute!(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: paddingHorizontal),
                                        child: AppLargeText(
                                          text: 'Şimdi Rota Oluştur',
                                          color: Colors.white,
                                        )),
                                    FaIcon(
                                      FontAwesomeIcons.road,
                                      color: Colors.white,
                                      size: 16,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Box_View(
                      boxInside: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child:
                                      AppLargeText(text: '${istasyon.name}')),
                              AppLargeText(text: '${istasyon.price} ₺/dk'),
                            ],
                          ),
                          Box_View(
                            horizontal: 0,
                            color: AppTheme.background,
                            boxInside: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(text: '${istasyon.formatedAdress}'),
                                App_Rich_Text(
                                    text: ['', 'Varış Süresi :', ' 33dk']),
                                App_Rich_Text(
                                    text: ['', 'Bekleme Süresi :', ' 33dk']),
                                App_Rich_Text(
                                    text: ['', 'Toplam Süre :', ' 33dk']),
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
                          Container(
                            padding:
                                EdgeInsets.only(bottom: paddingHorizontal * .5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppLargeText(text: 'Yoğunluk'),
                                AppLargeText(text: '${istasyon.doluluk}')
                              ],
                            ),
                          ),
                          Box_View(
                            horizontal: 0,
                            color: AppTheme.background,
                            boxInside: Container(
                              height: 200,
                              width: double.maxFinite,
                              alignment: Alignment.center,
                              child: CrowdedGraph(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Box_View(
                      boxInside: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppLargeText(text: 'Yorumlar'),
                              AppLargeText(text: '${istasyon.comment_rating}')
                            ],
                          ),
                          Box_View(
                            color: AppTheme.background,
                            horizontal: 0,
                            boxInside: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextfield(
                                        borderAvaliable: false,
                                        hintText: 'Sende Yorumunu Paylaş...',
                                        maxLineCount: 5,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: paddingHorizontal * .5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.camera,
                                      color: AppTheme.textColor,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(
                                          paddingHorizontal * .5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              paddingHorizontal),
                                          color: AppTheme.contrastColor1
                                              .withOpacity(.6)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  right:
                                                      paddingHorizontal * .5),
                                              child: AppText(
                                                text: 'Gönder',
                                                fontWeight: FontWeight.bold,
                                                size: 13,
                                                color: Colors.white,
                                              )),
                                          FaIcon(
                                            FontAwesomeIcons.paperPlane,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                            itemCount: 4,
                            padding: paddingZero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Box_View(
                                horizontal: 0,
                                color: AppTheme.background,
                                boxInside: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppLargeText(
                                            text: 'Yorum Sahibi $index'),
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      paddingHorizontal),
                                              child: AppLargeText(text: '4.4'),
                                            ),
                                            FaIcon(
                                              FontAwesomeIcons.star,
                                              color: AppTheme.textColor,
                                              size: 18,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    AppText(
                                        text:
                                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                                  ],
                                ),
                              );
                            },
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
      ],
    );
  }
}

class IstasyonDisplayer extends StatelessWidget {
  const IstasyonDisplayer({
    super.key,
    required this.currIstasyon,
  });

  final Istasyon currIstasyon;

  @override
  Widget build(BuildContext context) {
    return Box_View(
      boxInside: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: AppLargeText(text: currIstasyon.name)),
              Container(
                padding: EdgeInsets.only(left: paddingHorizontal),
                child: AppLargeText(text: '${currIstasyon.price} ₺/dk'),
              )
            ],
          ),
          Container(
              padding: EdgeInsets.only(top: paddingHorizontal * .5),
              child: AppText(text: 'Adres : ${currIstasyon.formatedAdress}')),
          Container(
            padding: EdgeInsets.symmetric(vertical: paddingHorizontal * .5),
            child: Row(
              children: [
                Expanded(
                  child: AppText(
                      text: 'Ortalama Şarj : ${currIstasyon.allTimeKW} KW'),
                ),
                Expanded(
                  child: AppText(
                      text: 'Anlık Şarj : ${currIstasyon.currentKW} KW'),
                ),
              ],
            ),
          ),
          AppText(text: 'Doluluk Oranı ${currIstasyon.doluluk}')
        ],
      ),
    );
  }
}
