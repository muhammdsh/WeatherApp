import 'package:weather/core/entities/base_entity.dart';

class WeatherEntity extends BaseEntity {
  final DateTime time;
  final double temp;
  final double dwpt;
  final double rhum;
  final double prcp;
  final double wdir;
  final double wspd;
  final double wpgt;
  final double pres;
  final int coco;
  final String status;
  final double tavg;
  final double tmin;
  final double tmax;
  final String image;

  WeatherEntity(
      {this.time,
      this.temp,
      this.tavg,
      this.tmin,
      this.tmax,
      this.dwpt,
      this.rhum,
      this.prcp,
      this.status,
      this.wdir,
      this.wspd,
      this.wpgt,
      this.pres,
      this.coco,
      this.image});

  WeatherEntity copyWith({
    DateTime time,
    double temp,
    double tavg,
    double tmin,
    double tmax,
    double dwpt,
    double rhum,
    double prcp,
    String status,
    double wdir,
    double wspd,
    double wpgt,
    double pres,
    String image,
    int coco,
  }) {
    return WeatherEntity(
        time: time ?? this.time,
        temp: temp ?? this.temp,
        tavg: tavg ?? this.tavg,
        tmin: tmin ?? this.tmin,
        tmax: tmax ?? this.tmax,
        dwpt: dwpt ?? this.dwpt,
        rhum: rhum ?? this.rhum,
        prcp: prcp ?? this.prcp,
        status: status ?? this.status,
        wdir: wdir ?? this.wdir,
        wspd: wspd ?? this.wspd,
        wpgt: wpgt ?? this.wpgt,
        pres: pres ?? this.pres,
        coco: coco ?? this.coco,
        image: image ?? this.image);
  }

  @override
  List<Object> get props => [
        time,
        temp,
        dwpt,
        image,
        rhum,
        prcp,
        tavg,
        tmin,
        tmax,
        wdir,
        wspd,
        wpgt,
        pres,
        coco,
      ];
}
