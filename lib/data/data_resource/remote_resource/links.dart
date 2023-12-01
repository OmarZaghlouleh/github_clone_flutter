import 'package:github_clone_flutter/domain/models/params/get_groups_params.dart';

abstract class Links {
  static const baseUrl = // "http://localhost:8000/api/";
      "http://192.168.1.104:8000/api/";
  //region auth
  static const register = "register";
  static const logout = "logout";
  static const login = "login";
  static const userProfile = "profile";
  static otherUserProfile(int id) => "profile/$id";
  static const updateUserProfile = "update_profile";
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
    return url;
  }
  //endregion
}
