import 'package:weather/core/error/base_error.dart';
import 'package:weather/core/param/base_param.dart';
import 'package:weather/core/resources/constants.dart';
import 'package:weather/core/result/result.dart';
import 'package:weather/core/usecases/base_use_case.dart';
import 'package:weather/data/requests/weather_request.dart';
import 'package:weather/domain/repositories/weather_repository.dart';
import 'package:weather/domain/usecases/data.dart';

import '../entities/weather_entity.dart';


class GetHourlyUseCase extends UseCase<
    Future<Result<BaseError, List<WeatherEntity>>>, GetWeatherParams> {
  final WeatherRepository weatherRepository;

  GetHourlyUseCase(this.weatherRepository);

  @override
  Future<Result<BaseError, List<WeatherEntity>>> call(
      GetWeatherParams params) async {
    final dateNow = DateTime.now();
    final String startDate = "${dateNow.year}-${dateNow.month.toString().padLeft(2, '0')}-${dateNow.day.toString().padLeft(2, '0')}";
    WeatherRequest request = WeatherRequest(
      endDate: startDate,
      latitude: params.latitude,
      longitude: params.longitude,
      startDate: startDate,
      units: params.units ?? "metric",
    );

    final result = await weatherRepository.getHourly(request);
    if (result.hasDataOnly) {
      return Result(
          data: result.data.map((e) {
        if (e.coco != null) {
          return e.copyWith(
              status: weatherConditions[e.coco],
              image: e.time.hour > 19
                  ? ImagesKeys.night
                  : weatherConditionsImages[e.coco]);
        } else {
          return e;
        }
      }).toList());
    }

    return result;
  }
}

class GetDailyUseCase extends UseCase<
    Future<Result<BaseError, List<WeatherEntity>>>, GetWeatherParams> {
  final WeatherRepository weatherRepository;

  GetDailyUseCase(this.weatherRepository);

  @override
  Future<Result<BaseError, List<WeatherEntity>>> call(GetWeatherParams params) {
    final dateNow = DateTime.now();
    final dateEnd = DateTime.now().add(const Duration(days: 7));
    final String startDate = "${dateNow.year}-${dateNow.month.toString().padLeft(2, '0')}-${dateNow.day.toString().padLeft(2, '0')}";
    final String endDate = "${dateEnd.year}-${dateEnd.month.toString().padLeft(2, '0')}-${dateEnd.day.toString().padLeft(2, '0')}";

    return weatherRepository.getDaily(WeatherRequest(
      endDate: endDate,
      latitude: params.latitude,
      longitude: params.longitude,
      startDate: startDate,
      units: params.units ?? "metric",
    ));
  }
}

class GetWeatherParams extends BaseParams {
  final double latitude;
  final double longitude;

  final String units;

  GetWeatherParams({
    this.latitude,
    this.longitude,
    this.units,
  });
}
