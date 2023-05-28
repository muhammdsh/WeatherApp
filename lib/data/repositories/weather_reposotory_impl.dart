import 'package:dartz/dartz.dart';
import 'package:weather/core/error/base_error.dart';
import 'package:weather/core/result/result.dart';
import 'package:weather/data/datasources/product_data_source/weather_data_source.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/data/requests/weather_request.dart';
import 'package:weather/domain/entities/weather_entity.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherDataSource weatherDataSource;

  WeatherRepositoryImpl(this.weatherDataSource);

  @override
  Future<Result<BaseError, List<WeatherEntity>>> getHourly(
      WeatherRequest weatherRequest) async {
    final memoizedResult = getMemoizedResult(request: weatherRequest);
    Either<BaseError, List<WeatherModel>> result;
    if (memoizedResult == null) {
      result = await weatherDataSource.getHourly(weatherRequest);
      memoizeResult(result: result, request: weatherRequest);
    } else {
      result = getMemoizedResult(request: weatherRequest)
          as Either<BaseError, List<WeatherModel>>;
    }
    return executeWithList(remoteResult: result);
  }

  @override
  Future<Result<BaseError, List<WeatherEntity>>> getDaily(
      WeatherRequest weatherRequest) async {
    final memoizedResult = getMemoizedResult(request: weatherRequest);
    Either<BaseError, List<WeatherModel>> result;
    if (memoizedResult == null) {
      result = await weatherDataSource.getDaily(weatherRequest);
      memoizeResult(result: result, request: weatherRequest);
    } else {
      result = getMemoizedResult(request: weatherRequest)
          as Either<BaseError, List<WeatherModel>>;
    }

    return executeWithList(remoteResult: result);
  }
}
