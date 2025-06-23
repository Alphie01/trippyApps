import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Weather {
  final String key;
  final String weatherName;
  final IconData weatherIcon;

  Weather(
      {required this.key,
      required this.weatherName,
      required this.weatherIcon});

  static final List<Weather> _weatherList = [
    Weather(
        key: 'sun', weatherName: 'Güneşli', weatherIcon: FontAwesomeIcons.sun),
    Weather(
        key: 'rain',
        weatherName: 'Yağmurlu',
        weatherIcon: FontAwesomeIcons.cloudRain),
    Weather(
        key: 'cloud',
        weatherName: 'Bulutlu',
        weatherIcon: FontAwesomeIcons.cloud),
    Weather(
        key: 'lightnin',
        weatherName: 'Sağanak Yağışlı',
        weatherIcon: FontAwesomeIcons.boltLightning),
  ];

  static Weather selectWithKey(String key) {
    return _weatherList.where((object) => object.key == key).first;
  }
}
