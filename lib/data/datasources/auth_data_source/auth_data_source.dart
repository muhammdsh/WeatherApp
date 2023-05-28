import 'package:weather/core/datasources/remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:weather/core/error/base_error.dart';

import '../../models/auth_model.dart';
import '../../requests/login_request.dart';
import '../../requests/otp_verification_request.dart';

abstract class AuthDataSource extends RemoteDataSource {
  Future<Either<BaseError, bool>> login(LoginRequest loginRequest);

  Future<Either<BaseError, AuthModel>> verifyOTP(OTPVerificationRequest otpVerificationRequest);

}