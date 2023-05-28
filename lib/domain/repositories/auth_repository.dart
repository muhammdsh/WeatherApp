import 'package:weather/core/repositories/repository.dart';
import 'package:weather/core/result/result.dart';
import 'package:weather/domain/entities/user_entity.dart';

import '../../core/error/base_error.dart';
import '../../data/requests/login_request.dart';
import '../../data/requests/otp_verification_request.dart';

abstract class AuthRepository extends Repository {
  Future<Result<BaseError, bool>> login(String number);

  Future<Result<BaseError, UserEntity>> verifyOTP(String number, String otpCode);

  Future<bool> logout();

  Future<bool> checkLoginStatus();
}

