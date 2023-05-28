import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:weather/core/mediators/communication_types/base_communication.dart';
import 'package:weather/domain/entities/location_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:weather/presentation/root_flow/bloc/root_bloc.dart';
import 'package:weather/presentation/root_flow/screens/root_page.dart';
import 'package:weather/presentation/weather_flow/bloc/weather_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../core/mediators/bloc_hub/bloc_member.dart';
import '../../../core/mediators/bloc_hub/members_key.dart';
import '../../../domain/usecases/getLocationUseCase.dart';

part 'location_event.dart';

part 'location_state.dart';

const throttleDuration = Duration(milliseconds: 100);

class LocationBloc extends Bloc<LocationEvent, LocationState> with BlocMember {
  final GetLocationUseCase getLocationUseCase;

  LocationBloc(this.getLocationUseCase) : super(const LocationState()) {
    on<GetLocationEvent>(
      _onGetLocations,
      transformer: throttleDroppable(throttleDuration),
    );

    on<SelectLocationEvent>(_onSelectLocation);
  }

  EventTransformer<E> throttleDroppable<E>(Duration duration) {
    return (events, mapper) {
      return droppable<E>().call(events.throttle(duration), mapper);
    };
  }

  @override
  void receive(String from, CommunicationType data) {
    // TODO: implement receive
  }
}

extension LocationMappers on LocationBloc {
  void _onGetLocations(
      GetLocationEvent event, Emitter<LocationState> emit) async {
    if (event.searchAddress.isEmpty) {
      emit(state.copyWith(
          status: LocationStatus.initial, searchAddress: event.searchAddress));
    } else {
      emit(state.copyWith(
          status: LocationStatus.loading, searchAddress: event.searchAddress));

      try {
        final result =
            await getLocationUseCase(LocationParams(event.searchAddress));
        emit(state.copyWith(
            status: LocationStatus.success, isError: false, data: result));
      } on Exception catch (e) {
        emit(state.copyWith(
            status: LocationStatus.failure,
            isError: true,
            error: e.toString()));
      }
    }
  }

  void _onSelectLocation(
      SelectLocationEvent event, Emitter<LocationState> emit) async {
    emit(state.copyWith(selectedLocation: state.data[event.selectedLocationIndex]));
    sendTo(WeatherLocation(state.data[event.selectedLocationIndex]), MembersKeys.weatherBloc);
    sendTo(TabCommunication(RootTabs.weather), MembersKeys.rootBloc);

  }
}

extension LocationActions on LocationBloc {
  void getLocations(String address) {
    add(GetLocationEvent(address));
  }

  void selectAddress(int index) {
    add(SelectLocationEvent(index));
  }
}
