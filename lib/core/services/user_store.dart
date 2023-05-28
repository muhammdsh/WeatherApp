import 'dart:convert';

import 'package:weather/core/resources/colors.dart';
import 'package:weather/data/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserStore {
  static final UserStore _instance = UserStore._internal();

  UserStore._internal();

  static const String keyUser = "USER_KEY";

  factory UserStore() {
    return _instance;
  }

  Future<SharedPreferences> _initStorage() {
    return SharedPreferences.getInstance();
  }

  Future<UserModel> getUserModel() async {
    final prefs = await _initStorage();

    if (await checkUserExistence()) {
      return UserModel.fromJson(json.decode(prefs.getString(keyUser)));
    } else {
      return UserModel();
    }
  }

  Future<void> setUserModel(UserModel userModel) async {
    final prefs = await _initStorage();

    prefs.setString(keyUser, jsonEncode(userModel.toJson()));
  }

  Future<bool> checkUserExistence() async {
    final prefs = await _initStorage();

    return prefs.containsKey(keyUser);
  }

  Future<bool> deleteUser() async {
    final prefs = await _initStorage();

    return prefs.remove(keyUser);
  }
}
