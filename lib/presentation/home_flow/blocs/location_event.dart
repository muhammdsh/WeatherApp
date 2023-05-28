part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class GetLocationEvent extends LocationEvent{

  final String searchAddress;

  GetLocationEvent(this.searchAddress);
}

class SelectLocationEvent extends LocationEvent {
  final int selectedLocationIndex;

  SelectLocationEvent(this.selectedLocationIndex);
}

class ResetLocationEvent extends LocationEvent {

}



