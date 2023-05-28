part of 'weather_bloc.dart';

enum WeatherPageStatus { init, success, error, loading }

class WeatherState extends Equatable {
  final LocationEntity location;
  final WeatherPageStatus status;
  final List<WeatherEntity> hourly;
  final List<WeatherEntity> daily;
  final String error;
  final String unit;

  WeatherState(
      {this.location,
      this.status = WeatherPageStatus.init,
      this.hourly = const [],
      this.daily = const [],
      this.error = "",
      this.unit = "metric"});

  WeatherState copyWith(
      {LocationEntity location,
      WeatherPageStatus status,
      String error,
      String unit,
      List<WeatherEntity> hourly,
      List<WeatherEntity> daily}) {
    return WeatherState(
        location: location ?? this.location,
        status: status ?? this.status,
        error: error ?? this.error,
        unit: unit ?? this.unit,
        hourly: hourly ?? this.hourly,
        daily: daily ?? this.daily);
  }

  @override
  List<Object> get props => [status, location, hourly, daily, error, unit];
}
