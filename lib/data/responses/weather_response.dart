import 'package:weather/data/models/auth_model.dart';
import 'package:weather/data/models/weather_model.dart';

import '../../core/response/api_response.dart';

class WeatherResponse extends ApiResponse<List<WeatherModel>> {
  WeatherResponse(
    String msg,
    bool hasError,
    List<WeatherModel> result,
  ) : super(msg, hasError, result);

  factory WeatherResponse.fromJson(json) {
    String message = '';
    bool isSuccess = json['data'] != null;
    List<WeatherModel> model;

    if (isSuccess) {
      model = (json['data'] as List)
          .map((e) {
        print('eTime: ${e["time"]}');
        return WeatherModel.fromJson(e); })
          .toList();

    } else {

      message = "Something went wrong";
    }

    return WeatherResponse(message, !isSuccess, model);
  }
}
