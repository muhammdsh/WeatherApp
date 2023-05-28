import 'package:dartz/dartz.dart';
import 'package:weather/core/error/base_error.dart';
import 'package:weather/core/result/result.dart';
import 'package:weather/core/services/session_manager.dart';
import 'package:weather/core/services/user_store.dart';
import 'package:weather/data/models/auth_model.dart';
import 'package:weather/domain/entities/user_entity.dart';
import 'package:weather/domain/repositories/auth_repository.dart';

import '../datasources/auth_data_source/auth_data_source.dart';
import '../requests/login_request.dart';
import '../requests/otp_verification_request.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource authDataSource;
  final SessionManager sessionManager;
  final UserStore userStore;

  AuthRepositoryImpl(
      {this.authDataSource, this.sessionManager, this.userStore});

  @override
  Future<Result<BaseError, bool>> login(String number) async {
    final result = await authDataSource.login(LoginRequest(number));

    return executeWithoutConvert(remoteResult: result);
  }

  @override
  Future<Result<BaseError, UserEntity>> verifyOTP(
      String number, String otpCode) async {
    final result = await authDataSource.verifyOTP(
        OTPVerificationRequest(phoneNumber: number, otpCode: otpCode));

    if (result.isRight()) {
      final data = (result as Right<BaseError, AuthModel>).value;
      final token = data.token;
      final refreshToken = data.refreshToken;

      sessionManager.persistToken(token);
      sessionManager.persistRefreshToken(refreshToken);

      userStore.setUserModel(data.user);
    }

    return execute(remoteResult: result);
  }

  @override
  Future<bool> logout() {
    try {
      sessionManager.deleteToken();
      userStore.deleteUser();
      return Future<bool>.value(true);
    } catch (e) {
      return Future<bool>.value(false);
    }
  }

  @override
  Future<bool> checkLoginStatus() {
    return sessionManager.hasToken;
  }
}
