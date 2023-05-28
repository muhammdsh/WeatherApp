import 'package:weather/core/param/base_param.dart';
import 'package:weather/domain/entities/location_entity.dart';

import '../../core/services/location_service.dart';
import '../../core/usecases/base_use_case.dart';

class GetLocationUseCase
    extends UseCase<Future<List<LocationEntity>>, LocationParams> {
  final LocationService locationService;

  GetLocationUseCase(this.locationService);

  @override
  Future<List<LocationEntity>> call(LocationParams params) async {
    final locations =
        await locationService.getLocationFromAddress(params.searchName);
    List<LocationEntity> result = [];
    print('locations: ${params.searchName} ${locations.length}');

    for (var location in locations) {
      final places = await locationService.getPlaceFromCoordinates(
          location.latitude, location.longitude);
      result.addAll(places
          .map((e) => LocationEntity(
              name: e.locality,
              country: e.country,
              street: e.street,
              lat: location.latitude,
              long: location.longitude))
          .toList());
    }

    return result;
  }
}

class LocationParams extends BaseParams {
  final String searchName;

  LocationParams(this.searchName);
}
