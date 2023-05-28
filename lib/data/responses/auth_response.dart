import 'package:weather/data/models/auth_model.dart';

import '../../core/response/api_response.dart';

class LoginResponse extends ApiResponse<bool> {
  LoginResponse(
      String msg,
      bool hasError,
      bool result,
      ) : super(msg, hasError, result);

  factory LoginResponse.fromJson(json) {
    print('hi there');
    int code = json['status_code'];
    String message = '';
    bool isSuccess = json['result'];
    bool model;

    if (isSuccess) {
      model =  json['result'];
    } else {
      message = json['message'];
    }

    return LoginResponse(message, !isSuccess, model);
  }
}

class VerifyOTPResponse extends ApiResponse<AuthModel> {
  VerifyOTPResponse(
      String msg,
      bool hasError,
      AuthModel result,
      ) : super(msg, hasError, result);

  factory VerifyOTPResponse.fromJson(json) {
    print('hi there');
    int code = json['status_code'];
    String message = '';
    bool isSuccess = json['result'];
    AuthModel model;

    if (isSuccess) {
      model =  AuthModel.fromJson(json['content']);
    } else {
      message = json['message'];
    }

    return VerifyOTPResponse(message, !isSuccess, model);
  }
}