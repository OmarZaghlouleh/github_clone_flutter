import 'package:github_clone_flutter/core/utils/utils_functions.dart';

import '../../../domain/models/params/get_groups_params.dart';

abstract class Links {
  static const baseUrl = "http://127.0.0.1:8000/api/";

  //region auth
  static const register = "register";
  static const logout = "logout";
  static const login = "login";
  static const userProfile = "profile";
  static otherUserProfile(int id) => "profile/$id";
  static const updateUserProfile = "update_profile";
  static const createGroup = "groups";
  static const getListUsers = "users?limit=1";
  static const addFilesToGroup="files";
  static String getGroups(GetGroupsParams getGroupsParams) {
    String url = "groups/user_groups/1?limit=1&page=${getGroupsParams.page}&";
    if (getGroupsParams.desc != "") {
      url += 'desc=${getGroupsParams.desc}&';
    }
    if (getGroupsParams.name != "") {
      url += 'name=${getGroupsParams.name}&';
    }
    if (getGroupsParams.order != "") {
      url += 'order=${getGroupsParams.order}';
    }
    dprint(url);
    return url;
  }

  //endregion
}
