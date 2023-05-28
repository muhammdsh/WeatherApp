import 'package:weather/core/mediators/bloc_hub/concrete_hub.dart';
import 'package:weather/core/mediators/communication_types/AppStatus.dart';
import 'package:weather/core/param/base_param.dart';
import 'package:weather/core/param/no_param.dart';
import 'package:weather/core/result/result.dart';
import 'package:weather/core/usecases/base_use_case.dart';
import 'package:weather/domain/entities/user_entity.dart';
import 'package:weather/domain/repositories/auth_repository.dart';

import '../../core/error/base_error.dart';

class LoginUseCase
    extends UseCase<Future<Result<BaseError, bool>>, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase({this.authRepository});

  @override
  Future<Result<BaseError, bool>> call(LoginParams params) {

    return authRepository.login(params.number);
  }
}

class VerifyOTPUseCase
    extends UseCase<Future<Result<BaseError, UserEntity>>, VerifyOTPParams> {
  final AuthRepository authRepository;

  VerifyOTPUseCase({this.authRepository});

  @override
  Future<Result<BaseError, UserEntity>> call(VerifyOTPParams params) {
    return authRepository.verifyOTP(params.number, params.otpCode);
  }
}

class LogoutUseCase
    extends UseCase<Future<bool>, NoParams> {
  final AuthRepository authRepository;

  LogoutUseCase({this.authRepository});

  @override
  Future<bool> call(NoParams params) {
    return authRepository.logout();
  }
}

class CheckLoginStatusUseCase
    extends UseCase<Future<Status>, NoParams> {
  final AuthRepository authRepository;

  CheckLoginStatusUseCase({this.authRepository});

  @override
  Future<Status> call(NoParams params) async {
    return (await authRepository.checkLoginStatus()) ? Status.authorized : Status.unauthorized;
  }
}

class LoginParams extends BaseParams {
  final String number;

  LoginParams({this.number});
}

class VerifyOTPParams extends BaseParams {
  final String number;
  final String otpCode;

  VerifyOTPParams({this.number, this.otpCode});
}
