import 'package:weather/core/request/request.dart';

class WeatherRequest extends Request {
  final double latitude;
  final double longitude;
  final String startDate;
  final String endDate;
  final String units;

  WeatherRequest({
     this.latitude,
     this.longitude,
     this.startDate,
     this.endDate,
     this.units,
  });

  Map<String, dynamic> toJson() {
    return {
      'lat': latitude,
      'lon': longitude,
      'start': startDate,
      'end': endDate,
      'units': units,
    };
  }
}