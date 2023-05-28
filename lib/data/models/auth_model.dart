import 'package:weather/core/entities/base_entity.dart';
import 'package:weather/core/models/base_model.dart';
import 'package:weather/domain/entities/user_entity.dart';

class AuthModel extends BaseModel<UserEntity> {
  UserModel user;
  String token;
  String refreshToken;

  AuthModel({this.user, this.token, this.refreshToken});

  AuthModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    token = json['token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user.toJson();
    }
    data['token'] = token;
    data['refresh_token'] = refreshToken;
    return data;
  }

  @override
  UserEntity toEntity() => user.toEntity();
}

class UserModel extends BaseModel<UserEntity> {
  int id;
  String name;
  String email;
  String phoneNumber;
  String avatar;
  String emailVerifiedAt;
  String phoneVerifiedAt;
  int isActive;
  String createdAt;
  String updatedAt;
  String refreshToken;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.avatar,
      this.emailVerifiedAt,
      this.phoneVerifiedAt,
      this.refreshToken,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    avatar = json['avatar'];
    emailVerifiedAt = json['email_verified_at'];
    phoneVerifiedAt = json['phone_verified_at'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['avatar'] = avatar;
    data['email_verified_at'] = emailVerifiedAt;
    data['phone_verified_at'] = phoneVerifiedAt;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['refresh_token'] = refreshToken;
    return data;
  }

  @override
  UserEntity toEntity() {
    return UserEntity(id, name, email, phoneNumber, avatar, emailVerifiedAt,
        phoneVerifiedAt, isActive);
  }
}
