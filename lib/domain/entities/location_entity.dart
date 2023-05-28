import 'package:weather/core/entities/base_entity.dart';

class LocationEntity extends BaseEntity {
  String name;
  String street;
  String country;
  double lat;
  double long;

  LocationEntity({ this.name, this.country, this.street, this.lat, this.long});

  @override
  List<Object> get props =>
      [ name, country, street, lat, long];
}
