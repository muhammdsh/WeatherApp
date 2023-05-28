import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather/core/request/request.dart';

class CreateProfileRequest extends Request {
  final String avatar;
  final String name;
  final String email;
  final String newPassword;
  final String newPasswordConfirmation;

  CreateProfileRequest(this.avatar, this.name, this.email, this.newPassword,
      this.newPasswordConfirmation);

  @override
  Map<String, dynamic> toJson() {
    final json = <String,dynamic>{};

    if (avatar != null && avatar.isNotEmpty) {
      json['avatar'] = MultipartFile.fromFileSync(avatar);
    }
    json['name'] = name;
    json['email'] = email;
    json['new_password'] = newPassword;
    json['new_password_confirmation'] = newPasswordConfirmation;

    return json;
  }
}

class UpdateProfileRequest extends Request {
  final String avatar;
  final String name;
  final String email;
  final String checkPassword;

  UpdateProfileRequest(this.avatar, this.name, this.email, this.checkPassword);

  @override
  Map<String, dynamic> toJson() {
    final json = <String,dynamic>{};
    if (avatar != null && avatar.isNotEmpty) {
      json['avatar'] = MultipartFile.fromFileSync(avatar);
    }
    if (name != null && name.isNotEmpty) {
      json['name'] = name;
    }
    if (email != null && email.isNotEmpty) {
      json['email'] = email;
    }
    json['check_password'] = checkPassword;

    return json;
  }
}

class ChangePasswordRequest extends Request {
  final String currentPassword;
  final String newPassword;
  final String newPasswordConfirmation;

  ChangePasswordRequest(
      this.currentPassword, this.newPassword, this.newPasswordConfirmation);

  @override
  Map<String, dynamic> toJson() {
    final json = <String,dynamic>{};

    json['current_password'] = currentPassword;
    json['new_password'] = newPassword;
    json['new_password_confirmation'] = newPasswordConfirmation;

    return json;
  }
}
