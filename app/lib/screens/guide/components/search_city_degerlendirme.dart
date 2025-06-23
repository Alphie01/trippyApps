
import 'package:TrippyAlpapp/core/classes/cities.dart';
import 'package:TrippyAlpapp/core/classes/subClasses/city_desc.dart';
import 'package:TrippyAlpapp/core/constants/sizeconfig.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Search_city_deger extends StatelessWidget {
  const Search_city_deger({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: DraggableScrollableSheet(
        builder: (_, controller) {
          return Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            padding: EdgeInsets.only(
                top: getPaddingScreenTopHeight(),
                bottom: getPaddingScreenBottomHeight()),
            child: ListView(
              controller: controller,
              padding: paddingZero,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                  child: AppLargeText(
                    text: 'Şehir Değerlendirmesi',
                    size: 24,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(paddingHorizontal),
                  child: AppText(
                    text:
                        "Şehirleri ziyaret eden gezginlerin deneyimlerini ve düşüncelerini keşfedin. Burada bulunan gerçek kullanıcı yorumları sayesinde şehir halkının samimi görüşlerine göz atabilir, yaşam tarzını, kültürel zenginlikleri ve yaşam maliyetlerini daha yakından anlayabilirsiniz. Bu bölüm, gezginler arasında paylaşılan gerçek deneyimlerin bir yansımasıdır ve size şehirleri tanıma ve keşfetme konusunda önemli ipuçları sunar. Şehir Kılavuzu'nun geniş ve güvenilir içeriği ile farklı şehirleri daha iyi anlamak ve kendi deneyimlerinizi paylaşmak artık çok daha kolay!",
                    maxLineCount: 999,
                  ),
                ),
                ListView.builder(
                  padding: paddingZero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Cities.selectedCites.cityScoreList.length,
                  itemBuilder: (ctx, index) {
                    return Degerlendirme_Widget(
                      cityScore: Cities.selectedCites.cityScoreList[index],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Degerlendirme_Widget extends StatefulWidget {
  final CityScore cityScore;
  const Degerlendirme_Widget({
    super.key,
    required this.cityScore,
  });

  @override
  State<Degerlendirme_Widget> createState() => _Degerlendirme_WidgetState();
}

class _Degerlendirme_WidgetState extends State<Degerlendirme_Widget> {
  bool isOpened = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(paddingHorizontal),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isOpened = !isOpened;
              });
            },
            child: Row(
              children: [
                Expanded(
                    child: Row(
                      children: [
                        FaIcon(
                          widget.cityScore.scoreIcon,
                          color: AppTheme.textColor,
                          size: 16,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: AppText(text: widget.cityScore.scoreName),
                        )
                      ],
                    ),
                    flex: 4),
                Expanded(
                    child: CityScoreCounter(
                      cityCounterCount: widget.cityScore.scoreCount,
                    ),
                    flex: 4),
                Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: isOpened
                          ? FaIcon(
                              FontAwesomeIcons.arrowUp,
                              color: AppTheme.textColor,
                            )
                          : FaIcon(
                              FontAwesomeIcons.arrowDown,
                              color: AppTheme.textColor,
                            ),
                    ),
                    flex: 1),
              ],
            ),
          ),
          isOpened
              ? Container(
                  padding: EdgeInsets.all(paddingHorizontal),
                  child: AppText(
                    text: widget.cityScore.scoresDesc,
                    maxLineCount: 9999,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

class CityScoreCounter extends StatefulWidget {
  const CityScoreCounter({super.key, required this.cityCounterCount});
  final double cityCounterCount;

  @override
  State<CityScoreCounter> createState() => _CityScoreCounterState();
}

class _CityScoreCounterState extends State<CityScoreCounter> {
  Color? boxColor;

  @override
  void initState() {
    setColor(widget.cityCounterCount);

    // TODO: implement initState
    super.initState();
  }

  void setColor(double count) {
    if (count > 66) {
      setState(() {
        boxColor = AppTheme.alertGreen[0];
      });
    } else if (count > 33 && count <= 66) {
      setState(() {
        boxColor = AppTheme.alertYellow[0];
      });
    } else if (count <= 33) {
      setState(() {
        boxColor = AppTheme.alertRed[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(paddingHorizontal),
          border: Border.all(color: boxColor!)),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: paddingHorizontal),
                    decoration: BoxDecoration(
                      color: boxColor,
                      borderRadius:
                          BorderRadius.circular(paddingHorizontal - 5),
                    ),
                  ),
                  flex: widget.cityCounterCount.toInt(),
                ),
                Expanded(
                  child: Container(
                    height: 10,
                  ),
                  flex: (100 - widget.cityCounterCount.toInt()),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: AppText(
              text: '${widget.cityCounterCount}',
              color: AppTheme.contrastColor1,
            ),
          )
        ],
      ),
    );
  }
}
