import 'package:TrippyAlpapp/core/classes/cityGuide/subclasses/city_desc.dart';
import 'package:TrippyAlpapp/core/classes/cityGuide/subclasses/weather.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Cities {
  final String cityKey;
  final String cityName;
  final List<NetworkImage> cityPhotos;
  final List<CityDesc> cityDesc;
  final List<CityFamous> cityFamous;
  final List<CityScore> cityScoreList;
  final List<CityGuide> cityGuide;
  final List<CityProsCons> cityProsCons;
  final Weather cityWeather;
  final double cityWeatherCelsius;

  Cities({
    required this.cityKey,
    required this.cityName,
    required this.cityDesc,
    required this.cityPhotos,
    required this.cityFamous,
    required this.cityScoreList,
    required this.cityGuide,
    required this.cityProsCons,
    required this.cityWeatherCelsius,
    required this.cityWeather,
  });

  static Cities selectedCites = Cities(
    cityKey: 'bursa',
    cityName: 'Bursa',
    cityDesc: [
      CityDesc(
          descTitle: 'Şehir Hakkında',
          descText:
              "Ekonomik açıdan Türkiye'nin en gelişmiş kentlerinden biri olan Bursa doğal ve tarihsel zenginlikleriyle de önem taşır. Bursa'da en çok Osmanlı İmparatorluğu'nun kuruluş dönemine ait tarihi eserlerin bulunmasının sebebi ise, Bursa'nın Osmanlı Devletinin ilk başkenti olmasıdır. Bursa alışveriş merkezleri, parkları, müzeleri ve çarşısıyla bölgede öne çıkar. Ayrıca Bursa Marmara bölgesinin İstanbul'dan sonra gelen ikinci büyük şehridir. Türkiye'nin en önemli birkaç sanayi kentinden biridir."),
      CityDesc(
          descTitle: 'Tarihçe',
          descText:
              "Bursa'da şimdilik bilinen en eski arkeolojik kalıntılar Yenişehir yakınlarındaki Menteşe Höyüğü ve Orhangazi yakınlarındaki Ilıpınar'dan bilinmektedir. Bu arkeolojik buluntu yerlerinin en eski tabakaları yaklaşık 7 bin yıllıktır. Bu tabakalardaki kültür, çanak çömleğin gelişmiş olarak ortaya çıktığı, mimarinin dörtgen planlı, bol miktarda ahşap destekli kerpiç kullanılarak inşa edilmiş yapılardan oluştuğu tabakalardır. Bursa'da David French, Mehmet Özdoğan ve Jacop Roodenberg'in arkeoloji ile ilgili çalışmaları tarih öncesiyle ilgili pek çok yeni bilgi ortaya koymuştur.\n\n Bursa ve civarında MÖ 4000'li yıllardan itibaren çeşitli yerleşimlerin olduğu saptanmıştır; fakat yöreye ait kesin bilgiler MÖ 700'lere dayanmaktadır. Homeros, bölgeden Mysia[3] olarak söz etmektedir. Günümüzde Bursa yöresinde Mysia yerleşmelerini anımsatan iki köy bulunmaktadır: Misi (Gümüştepe) ve Misebolu. Ayrıca Prof. Dr. Semavi Eyice, belgesel yönetmeni Tekin Gün yaptığı yüzey çalışmaları sırasında Kentin 14 km batısında, Çayırköyü’nün 1 km güneybatısındaki “Çayırköy Höyüğü’nün” boyutları da Demirtaş Höyüğü ile aynıdır. Burada bulunan seramik parçalarında gri, kırmızı, kahverengi ve siyah renkler hakimdir. Bulunan seramik parçalarının önemli kısmı elde yapılmış, çok azı ise çarkta yapılmıştır. Höyüğün en eski buluntusu MÖ. 2700-2500 yılına erken Bronz Çağı'na işaret etmektedir."),
      CityDesc(
          descTitle: 'Ekonomi',
          descText:
              "2007 yılı nüfus sayımı resmî kesin sonuçlarına göre Türkiye'nin 4. büyük kentidir. Brookings Institution ve JP Morgan'ın 2014 yılı baz alınarak oluşturulan ekonomide yükselen kentler sıralamasında Bursa 300 şehir arasında İstanbul'un ardından 4. sırayı aldı. Aynı listede Türkiye'den İstanbul ve Bursa dışında İzmir 2 ve Ankara 9. sırada yer almıştır.")
    ],
    cityPhotos: [
      NetworkImage(
          'https://upload.wikimedia.org/wikipedia/commons/7/70/Irgand%C4%B1_k%C3%B6pr%C3%BCs%C3%BC_bursa_-_panoramio.jpg'),
      NetworkImage(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Cumhuriyet_cd.Bursa_-_panoramio_%283%29.jpg/2560px-Cumhuriyet_cd.Bursa_-_panoramio_%283%29.jpg'),
      NetworkImage(
          'https://images.pexels.com/photos/16045962/pexels-photo-16045962/free-photo-of-bina-agaclar-masa-balkon.jpeg?auto=compress&cs=tinysrgb&w=800'),
      NetworkImage(
          'https://images.pexels.com/photos/15021701/pexels-photo-15021701/free-photo-of-tekneler-kayalar-gol-acik-hava.jpeg?auto=compress&cs=tinysrgb&w=800'),
      NetworkImage(
          'https://images.pexels.com/photos/16059630/pexels-photo-16059630/free-photo-of-sanat-ic-din-kubbe.jpeg?auto=compress&cs=tinysrgb&w=800'),
    ],
    cityFamous: [
      CityFamous(
          famousName: 'İskender',
          famousDesc:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
      CityFamous(
          famousName: 'Cantık',
          famousDesc:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
      CityFamous(
          famousName: 'İnegöl Köfte',
          famousDesc:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
      CityFamous(
          famousName: 'Pideli Köfte',
          famousDesc:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
      CityFamous(
          famousName: 'Kemalpaşa Tatlısı',
          famousDesc:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
      CityFamous(
          famousName: 'Süt hHelvası',
          famousDesc:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
    ],
    cityScoreList: [
      CityScore(
          scoreName: 'Yaşam Puanı',
          scoresDesc:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          scoreCount: 66),
      CityScore(
          scoreName: 'Aile İçin',
          scoresDesc:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          scoreCount: 33),
      CityScore(
          scoreName: 'Topluluk',
          scoresDesc:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          scoreCount: 66),
      CityScore(
          scoreName: 'Yaşam Maliyeti',
          scoresDesc:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          scoreCount: 100),
    ],
    cityGuide: [
      CityGuide(
          guideName: 'Ailenin Yaşam Maliyeti',
          guideText: "30.000₺",
          guideDesc:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
      CityGuide(
          guideName: 'Günlük Yemek Maliyetleri(Dışarıdan)',
          guideText: "200₺",
          guideDesc:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
      CityGuide(
          guideName: 'Market Masrafları(Günlük)',
          guideText: "1100₺",
          guideDesc:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
      CityGuide(
          guideName: 'Alkollü İçecekler',
          guideText: "65₺",
          guideDesc:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
      CityGuide(
          guideName: 'Kahve Türevleri',
          guideText: "54₺",
          guideDesc:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
    ],
    cityProsCons: [
      CityProsCons(prosconsTitle: 'Yaşanabilir Maliyet', prosconsIsPros: true),
      CityProsCons(prosconsTitle: 'Yaşanabilir İklim', prosconsIsPros: true),
      CityProsCons(
          prosconsTitle: 'Yaşanabilir Hava Kalitesi', prosconsIsPros: true),
      CityProsCons(
          prosconsTitle: 'Toplulukta Arkadaş Edinme', prosconsIsPros: true),
      CityProsCons(prosconsTitle: 'Konumşma Özgürlüğü', prosconsIsPros: false),
      CityProsCons(prosconsTitle: 'Gezgin Özgürlüğü', prosconsIsPros: false),
      CityProsCons(prosconsTitle: 'Yavaş İnternet', prosconsIsPros: false),
      CityProsCons(
          prosconsTitle: 'Yapılacak Etkinlikler Az', prosconsIsPros: false),
    ],
    cityWeather: Weather.selectWithKey('rain'),
    cityWeatherCelsius : 32.1
  );

  static void init(String cityName) {
    //TODO Serverden çekilecek Şuanki Şehir bilgileri
  }
}
