part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class SetLocationEvent extends WeatherEvent {
  final LocationEntity locationEntity;
  final String unit;

  SetLocationEvent({this.locationEntity, this.unit});
}

