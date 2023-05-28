part of 'location_bloc.dart';

enum LocationStatus { initial, success, failure, loading }

class LocationState extends Equatable {
  final LocationStatus status;
  final List<LocationEntity> data;
  final LocationEntity selectedLocation;
  final String searchAddress;
  final bool isError;
  final String error;

  const LocationState(
      {this.status = LocationStatus.initial,
      this.data = const [],
      this.selectedLocation,
      this.searchAddress = "",
      this.isError,
      this.error});

  LocationState copyWith(
      {LocationStatus status,
      String searchAddress,
      List<LocationEntity> data,
      LocationEntity selectedLocation,
      bool isError,
      String error}) {
    return LocationState(
        status: status ?? this.status,
        data: data ?? this.data,
        selectedLocation: selectedLocation ?? this.selectedLocation,
        searchAddress: searchAddress ?? this.searchAddress,
        isError: isError ?? this.isError,
        error: error ?? this.error);
  }

  @override
  List<Object> get props =>
      [status, data, error, isError, searchAddress, selectedLocation];
}
