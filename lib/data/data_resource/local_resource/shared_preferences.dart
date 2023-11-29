import 'package:github_clone_flutter/domain/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalResource {
  static late SharedPreferences sharedPreferences;

  static Future<void> initLocalResource() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static bool getIfUserRegistered() {
    if (sharedPreferences.getString('token') != null &&
        sharedPreferences.getString('token')!.isNotEmpty &&
        sharedPreferences.getInt('roleId') != null &&
        sharedPreferences.getInt('roleId')! > 0 &&
        sharedPreferences.getString('roleName') != null &&
        sharedPreferences.getString('roleName')!.isNotEmpty) {
      return true;
    }
    return false;
  }

  static saveUserData(AuthModel authModel) {
    LocalResource.sharedPreferences.setString('token', authModel.token);
    LocalResource.sharedPreferences.setInt('roleId', authModel.roleId);
    LocalResource.sharedPreferences.setString('roleName', authModel.roleName);
  }
}
