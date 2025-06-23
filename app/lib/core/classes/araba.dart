import 'package:flutter/material.dart';
import 'package:TrippyAlpapp/core/httpRequests/http.dart';

class ArabaBrand {
  final int arabaBrandId;
  final String arabaBrandName;
  final NetworkImage? arabaBrandLogo, arabaBrandLogoLight;

  ArabaBrand(
      {required this.arabaBrandId,
      required this.arabaBrandName,
      this.arabaBrandLogo,
      this.arabaBrandLogoLight});

  static List<ArabaBrand> allarabaBrands = [];
  static Future<List<ArabaBrand>> initializeCarBrands() async {
    if (allarabaBrands.isNotEmpty) {
      return allarabaBrands;
    }
    List<ArabaBrand> _arabaBrands = [];
    Map<String, dynamic> data = {'fetchCars': 'ok'};
    Map returns = await HTTP_Requests.sendPostRequest('get_cars', data);
    if (returns['id'] == 0) {
      if (allarabaBrands.isEmpty) {
        allarabaBrands = _arabaBrands;
      }
      _arabaBrands = brandCreotor(returns['returns']);
      return _arabaBrands;
    } else {
      return [];
    }
  }

  static List<ArabaBrand> brandCreotor(List json) {
    List<ArabaBrand> _return = [];

    for (var element in json) {
      _return.add(createBrand(
        element['araba_brand_id'],
        element['araba_brand_name'],
        element['araba_brand_logoDark'],
        element['araba_brand_logoLight'],
      ));
    }

    return _return;
  }

  static ArabaBrand createBrand(int arabaBrandId, String arabaBrandName,
      String? arabaBrandLogo, String? arabaBrandLogoLight) {
    return ArabaBrand(
      arabaBrandId: arabaBrandId,
      arabaBrandName: arabaBrandName,
      arabaBrandLogo:
          arabaBrandLogo != null ? NetworkImage(arabaBrandLogo) : null,
      arabaBrandLogoLight:
          arabaBrandLogo != null ? NetworkImage(arabaBrandLogoLight!) : null,
    );
  }
}

class ArabaModel {
  final ArabaBrand arabaBrand;
  final int modelId;
  final String vechileType, vechileModel, releaseDate;
  final String? variant;
  ArabaModel(
      {required this.arabaBrand,
      required this.modelId,
      required this.vechileType,
      required this.vechileModel,
      required this.releaseDate,
      this.variant});

  static Future<List<ArabaModel>> initializeCarBrands(
      ArabaBrand arabaBrand) async {
    List<ArabaModel> _arabaModel = [];
    Map<String, dynamic> data = {
      'fetchCars': 'ok',
      'araba_brand_id': arabaBrand.arabaBrandId
    };
    Map returns = await HTTP_Requests.sendPostRequest('get_cars', data);
    print(returns['returns']);
    if (returns['id'] == 0) {
      _arabaModel = modelCreotor(arabaBrand, returns['returns']);
      return _arabaModel;
    } else {
      return [];
    }
  }

  static List<ArabaModel> modelCreotor(ArabaBrand arabaBrand, List json) {
    List<ArabaModel> _return = [];

    for (var element in json) {
      _return.add(
        _createModel(
          arabaBrand,
          element['araba_id'],
          element['araba_vehicle_type'],
          element['araba_model'],
          element['araba_release_year'],
          element['araba_variant'],
        ),
      );
    }

    return _return;
  }

  static ArabaModel _createModel(
    ArabaBrand arabaBrand,
    int modelId,
    String vechileType,
    String vechileModel,
    String releaseDate,
    String? variant,
  ) =>
      ArabaModel(
        modelId: modelId,
        arabaBrand: arabaBrand,
        vechileType: vechileType,
        vechileModel: vechileModel,
        releaseDate: releaseDate,
        variant: variant,
      );
}
