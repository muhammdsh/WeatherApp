import 'package:weather/data/models/auth_model.dart';

import '../../core/response/api_response.dart';

class UserResponse extends ApiResponse<UserModel> {
  UserResponse(
    String msg,
    bool hasError,
    UserModel result,
  ) : super(msg, hasError, result);

  factory UserResponse.fromJson(json) {
    print('hi there');
    int code = json['status_code'];
    String message = '';
    bool isSuccess = json['result'];
    UserModel model;

    if (isSuccess) {
      model = UserModel.fromJson(json['content']);
    } else {
      List<String> listOfErrors = ((json['message'] as Map)
          .values
          .toList().first as List)
          .map((e) => e.toString())
          .toList();
      message = listOfErrors.first;
    }

    return UserResponse(message, !isSuccess, model);
  }
}

class CheckUserResponse extends ApiResponse<bool> {
  CheckUserResponse(
    String msg,
    bool hasError,
    bool result,
  ) : super(msg, hasError, result);

  factory CheckUserResponse.fromJson(json) {
    print('hi thereeworepoirpewoi');
    int code = json['status_code'];
    String message = '';
    bool isSuccess = json['result'];
    bool model;

    if (isSuccess) {
      model = json['content'];
    } else {
      message = json['message'];
    }

    return CheckUserResponse(message, !isSuccess, model);
  }
}
