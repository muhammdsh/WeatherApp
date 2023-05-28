import 'package:weather/core/models/base_model.dart';

import '../../domain/entities/weather_entity.dart';

class WeatherModel extends BaseModel<WeatherEntity> {
  final DateTime time;
  final double temp;
  final double dwpt;
  final double rhum;
  final double prcp;
  final double snow;
  final double wdir;
  final double wspd;
  final double wpgt;
  final double pres;
  final double tsun;
  final int coco;
  final double tavg;
  final double tmin;
  final double tmax;

  WeatherModel({
    this.time,
    this.temp,
    this.dwpt,
    this.rhum,
    this.prcp,
    this.snow,
    this.wdir,
    this.wspd,
    this.wpgt,
    this.pres,
    this.tsun,
    this.coco,
    this.tavg,
    this.tmin,
    this.tmax,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      time: DateTime.parse(json['time']?? json['date']),
      temp: json['temp']?.toDouble() ?? 0,
      dwpt: json['dwpt']?.toDouble() ?? 0,
      rhum: json['rhum']?.toDouble() ?? 0,
      prcp: json['prcp']?.toDouble() ?? 0,
      snow: json['snow']?.toDouble()?? 0,
      wdir: json['wdir']?.toDouble()?? 0,
      wspd: json['wspd']?.toDouble()?? 0,
      wpgt: json['wpgt']?.toDouble()?? 0,
      pres: json['pres']?.toDouble()?? 0,
      tsun: json['tsun']?.toDouble()?? 0,
      coco: json['coco']?? 1,
      tavg: json['tavg']?.toDouble()?? 0,
      tmin: json['tmin']?.toDouble()?? 0,
      tmax: json['tmax']?.toDouble()?? 0,
    );
  }

  @override
  WeatherEntity toEntity() => WeatherEntity(
      temp: temp,
      coco: coco,
      dwpt: dwpt,
      prcp: prcp,
      pres: pres,
      rhum: rhum,
      time: time,
      tavg: tavg,
      tmin: tmin,
      tmax: tmax,
      wdir: wdir,
      wpgt: wpgt,
      wspd: wspd);
}
