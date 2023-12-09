import 'dart:developer';

import 'package:github_clone_flutter/core/utils/extensions/print.dart';
import 'package:github_clone_flutter/domain/models/auth_model.dart';
import 'package:github_clone_flutter/domain/models/create_update_group_model.dart';
import 'package:github_clone_flutter/domain/models/group_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/utils_functions.dart';

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
        sharedPreferences.getInt('userId') != null &&
        sharedPreferences.getInt('userId')! > 0 &&
        sharedPreferences.getString('roleName') != null &&
        sharedPreferences.getString('roleName')!.isNotEmpty) {
      return true;
    }
    return false;
  }

  static Future<void> saveUserData(AuthModel authModel) async {
    await sharedPreferences.setString('token', authModel.token);
    await sharedPreferences.setInt('roleId', authModel.roleId);
    await sharedPreferences.setInt('userId', authModel.userId);
    await sharedPreferences.setString('roleName', authModel.roleName);
    dprint(sharedPreferences.getString('token'));
  }

  static getIfAdmin() {
    return sharedPreferences.getInt('roleId') == 1;
  }

  static deleteUserData() {
    sharedPreferences.remove('token');
    sharedPreferences.remove('roleId');
    sharedPreferences.remove('roleName');
  }

  static saveGroupData(CreateUpdateGroupModel createUpdateGroupModel) {
    LocalResource.sharedPreferences.setString(
        createUpdateGroupModel.name, createUpdateGroupModel.groupKey);
  }
}
