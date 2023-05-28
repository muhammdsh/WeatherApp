import 'package:dartz/dartz.dart';
import 'package:weather/core/datasources/api_call_params.dart';
import 'package:weather/core/datasources/function_instance.dart';
import 'package:weather/core/enums/api/HttpMethod.dart';
import 'package:weather/core/resources/apis.dart';
import 'package:weather/data/datasources/product_data_source/weather_data_source.dart';

import 'package:weather/data/models/weather_model.dart';
import 'package:weather/data/requests/weather_request.dart';
import 'package:weather/data/responses/weather_response.dart';

import '../../../core/error/base_error.dart';

class WeatherDataSourceImpl extends WeatherDataSource {

  @override
  Future<Either<BaseError, List<WeatherModel>>> getHourly(
      WeatherRequest weatherRequest) {
    ApiCallFunction instance = ApiCallFunction(
        () => request<List<WeatherModel>, WeatherResponse>(
            ApiCallParams<WeatherResponse>(
                responseStr: "WeatherResponse",
                data: weatherRequest.toJson(),
                mapper: (json) => WeatherResponse.fromJson(json),
                method: HttpMethod.GET,
                refreshCaller: 'WeatherDataSourceImpl-getHourly',
                url: ApiUrls.hourly)),
        []);

    addFunction('WeatherDataSourceImpl-getProducts', instance);

    return instance.invoke<List<WeatherModel>>();
  }

  @override
  Future<Either<BaseError, List<WeatherModel>>> getDaily(
      WeatherRequest weatherRequest) {
    return request<List<WeatherModel>, WeatherResponse>(ApiCallParams(
        responseStr: "WeatherResponse",
        data: weatherRequest.toJson(),
        mapper: (json) => WeatherResponse.fromJson(json),
        method: HttpMethod.GET,
        url: ApiUrls.daily));
  }
}
