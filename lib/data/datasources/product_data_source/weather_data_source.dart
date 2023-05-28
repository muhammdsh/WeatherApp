import 'package:dartz/dartz.dart';
import 'package:weather/core/datasources/remote_data_source.dart';
import 'package:weather/core/error/base_error.dart';
import 'package:weather/core/request/request.dart';
import 'package:weather/data/models/category_model.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/data/requests/weather_request.dart';

abstract class WeatherDataSource extends RemoteDataSource {
  Future<Either<BaseError, List<WeatherModel>>> getHourly(
      WeatherRequest weatherRequest);

  Future<Either<BaseError, List<WeatherModel>>> getDaily(
      WeatherRequest weatherRequest);
}
