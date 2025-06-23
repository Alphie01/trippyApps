import 'package:flutter/material.dart';
import 'package:TrippyAlpapp/core/classes/araba.dart';
import 'package:TrippyAlpapp/core/constants/sizeconfig.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:TrippyAlpapp/widgets/box_view.dart';

class ArabaSelection extends StatefulWidget {
  final Function(ArabaModel) setSelectedModel;
  const ArabaSelection({
    super.key,
    required this.setSelectedModel,
  });

  @override
  State<ArabaSelection> createState() => _ArabaSelectionState();
}

class _ArabaSelectionState extends State<ArabaSelection> {
  List<ArabaBrand> arabaBrands = [];
  List<ArabaModel> arabaModels = [];
  ArabaBrand? selectedBrand;
  ArabaModel? selectedModel;
  bool selectButton = false, fetchingModels = false;
  @override
  void initState() {
    initCarBrands();
    // TODO: implement initState
    super.initState();
  }

  Future initCarBrands() async {
    List<ArabaBrand> fetched = await ArabaBrand.initializeCarBrands();
    setState(() {
      arabaBrands = fetched;
    });
    print(arabaBrands.length);
  }

  Future fetchModels(ArabaBrand brand) async {
    setState(() {
      fetchingModels = true;
      selectedBrand = brand;
    });
    List<ArabaModel> models = await ArabaModel.initializeCarBrands(brand);
    setState(() {
      arabaModels = models;
      fetchingModels = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        DraggableScrollableSheet(
          initialChildSize: .9,
          maxChildSize: .9,
          builder: (_, controller) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: AppBlackTheme.background,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(paddingHorizontal),
                  ),
                ),
                padding: EdgeInsets.only(
                  top: paddingHorizontal,
                  bottom: getPaddingScreenBottomHeight(),
                ),
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 75),
                  controller: controller,
                  children: [
                    Box_View(
                      color: AppBlackTheme.background1,
                      boxInside: Column(
                        children: [
                          Row(
                            children: [
                              AppLargeText(
                                text: 'Arabanı Seç',
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Container(
                            child: AppText(
                              text:
                                  'Araba seçimizin uygulamanın daha efektif bir şekilde sizleri yönlendirmesi için hazırlanmıştır. Arabanızın Marka Modelini belirterek daha efektif şekilde sizleri yönlendirmemizi sağlayın!',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Box_View(
                      color: AppBlackTheme.background1,
                      boxInside: selectedBrand != null
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedBrand = null;
                                  arabaModels = [];
                                  selectButton = false;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: AppLargeText(
                                      text: 'Arabanın Markası',
                                      color: Colors.white,
                                    ),
                                  ),
                                  AppLargeText(
                                      text: '${selectedBrand!.arabaBrandName}',
                                      color: Colors.white)
                                ],
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(
                                        bottom: paddingHorizontal),
                                    child: AppLargeText(
                                      text: 'Arabanın Markasını Seçiniz',
                                      color: Colors.white,
                                    )),
                                ListView.builder(
                                  shrinkWrap: true,
                                  padding: paddingZero,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: arabaBrands.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    ArabaBrand brand = arabaBrands[index];
                                    return GestureDetector(
                                      onTap: () => fetchModels(brand),
                                      child: Box_View(
                                        horizontal: 0,
                                        color: AppBlackTheme.background,
                                        boxInside: Row(
                                          children: [
                                            AppLargeText(
                                              text: brand.arabaBrandName,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                    ),
                    selectedBrand != null
                        ? fetchingModels
                            ? Box_View(
                                boxInside: Container(
                                height: 250,
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              ))
                            : Box_View(
                                boxInside: Column(
                                  children: [
                                    Row(
                                      children: [
                                        AppLargeText(text: 'Arabanın Modeli')
                                      ],
                                    ),
                                    ListView.builder(
                                      itemCount: arabaModels.length,
                                      shrinkWrap: true,
                                      padding: paddingZero,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        ArabaModel model = arabaModels[index];
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedModel = model;
                                            });
                                            selectButton = true;
                                          },
                                          child: Box_View(
                                              horizontal: 0,
                                              border: selectedModel == model
                                                  ? Border.all(
                                                      color: AppTheme
                                                          .contrastColor1)
                                                  : null,
                                              color: AppBlackTheme.background,
                                              boxInside: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AppLargeText(
                                                      text: model.vechileModel),
                                                  AppText(
                                                      text:
                                                          '${model.variant ?? ""}')
                                                ],
                                              )),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                        : Container()
                  ],
                ),
              ),
            );
          },
        ),
        selectButton
            ? GestureDetector(
                onTap: () => widget.setSelectedModel(selectedModel!),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: getPaddingScreenBottomHeight(),
                      horizontal: paddingHorizontal),
                  child: Box_View(
                    color: AppTheme.contrastColor1,
                    boxInside: Row(
                      children: [AppLargeText(text: 'Seç')],
                    ),
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
