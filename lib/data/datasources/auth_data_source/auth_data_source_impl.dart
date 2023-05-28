import 'package:dartz/dartz.dart';
import 'package:weather/core/datasources/api_call_params.dart';
import 'package:weather/core/datasources/remote_data_source.dart';
import 'package:weather/core/enums/api/HttpMethod.dart';

import 'package:weather/core/error/base_error.dart';
import 'package:weather/core/resources/apis.dart';

import 'package:weather/data/models/auth_model.dart';

import 'package:weather/data/requests/login_request.dart';

import 'package:weather/data/requests/otp_verification_request.dart';
import 'package:weather/data/responses/auth_response.dart';

import 'auth_data_source.dart';

class AuthDataSourceImpl extends AuthDataSource {
  @override
  Future<Either<BaseError, bool>> login(LoginRequest loginRequest) {
    return request<bool, LoginResponse>(
         ApiCallParams(
      responseStr: "LoginResponse",
      mapper: (json) => LoginResponse.fromJson(json),
      data: loginRequest.toJson(),
      method: HttpMethod.POST,
     // url: ApiUrls.login,
    ));
  }

  @override
  Future<Either<BaseError, AuthModel>> verifyOTP(
      OTPVerificationRequest otpVerificationRequest) {
    return request<AuthModel, VerifyOTPResponse>(
         ApiCallParams(
            responseStr: 'VerifyOTPResponse',
            mapper: (json) => VerifyOTPResponse.fromJson(json),
            data: otpVerificationRequest.toJson(),
            method: HttpMethod.POST,
       //    url: ApiUrls.otpVerification
         ));
  }
}
