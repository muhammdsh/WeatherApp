import 'package:weather/core/repositories/repository.dart';
import 'package:weather/core/result/result.dart';
import 'package:weather/data/requests/weather_request.dart';

import '../../core/error/base_error.dart';
import '../entities/weather_entity.dart';

abstract class WeatherRepository extends Repository {
  Future<Result<BaseError, List<WeatherEntity>>> getHourly(
      WeatherRequest weatherRequest);

  Future<Result<BaseError, List<WeatherEntity>>> getDaily(
      WeatherRequest weatherRequest);
}
