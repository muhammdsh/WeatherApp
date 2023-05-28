import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather/core/mediators/bloc_hub/bloc_member.dart';
import 'package:weather/core/mediators/communication_types/base_communication.dart';
import 'package:weather/domain/entities/location_entity.dart';
import 'package:weather/domain/entities/weather_entity.dart';

import '../../../domain/usecases/weather_usecases.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> with BlocMember {
  final GetHourlyUseCase getHourlyUseCase;
  final GetDailyUseCase getDailyUseCase;

  WeatherBloc(this.getHourlyUseCase, this.getDailyUseCase)
      : super(WeatherState()) {
    on<SetLocationEvent>(_onSetLocation);
  }

  @override
  void receive(String from, CommunicationType data) {
    if (data is WeatherLocation) {
      setLocation(locationEntity: data.locationEntity, unit: state.unit);
    }
  }
}

extension WeatherBlocMappers on WeatherBloc {
  void _onSetLocation(
      SetLocationEvent event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(location: event.locationEntity, unit: event.unit));
    if (state.location != null) {
      emit(state.copyWith(
        status: WeatherPageStatus.loading,
      ));
      final results = await Future.wait([
        getHourlyUseCase(GetWeatherParams(
            latitude: state.location.lat,
            longitude: state.location.long,
            units: state.unit)),
        getDailyUseCase(GetWeatherParams(
            latitude: state.location.lat,
            longitude: state.location.long,
            units: state.unit))
      ]);

      if (results[0].hasDataOnly && results[1].hasDataOnly) {
        emit(state.copyWith(
            daily: results[1].data,
            hourly: results[0].data,
            status: WeatherPageStatus.success));
      } else {
        emit(state.copyWith(
            status: WeatherPageStatus.error, error: "Something Went Wrong"));
      }
    }
  }
}

extension WeatherBlocActions on WeatherBloc {
  void setLocation({LocationEntity locationEntity, String unit}) {
    add(SetLocationEvent(locationEntity: locationEntity, unit: unit));
  }
}

class WeatherLocation extends CommunicationType {
  final LocationEntity locationEntity;

  WeatherLocation(this.locationEntity);
}
