import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/domain/models/params/get_files_params.dart';
import 'package:github_clone_flutter/domain/models/params/get_reports_params.dart';

import '../../../domain/models/params/get_groups_params.dart';

abstract class Links {
  static const baseUrl =
      // "http://192.168.43.225:8000/api/";
      "http://127.0.0.1:8000/api/";

  //region auth
  static const register = "register";
  static const logout = "logout";
  static const login = "login";
  static const userProfile = "profile";
  static otherUserProfile(int id) => "profile/$id";
  static const updateUserProfile = "update_profile";
  static const createGroup = "groups";
  static const getListUsers = "users?limit=1";
  static String getGroups(GetGroupsParams getGroupsParams) {
    String url = "groups/user_groups?page=${getGroupsParams.page}&";
    // limit=1&
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

  static String getFiles(GetFilesParams getFilesParams) {
    String url = "";
    if (getFilesParams.key == "") {
      //user files
      url = "files/user_files?page=${getFilesParams.page}&";
      //   {{URL}}/api/files/user_files?order=created_at&desc=asc&name=
    } else {
      url =
          "files/group_files/${getFilesParams.key}?page=${getFilesParams.page}&";
// {{URL}}/api/files/group_files/IBa6oueTLvVTOFmr63WIXINr4zHeDTwN?order=created_at&desc=asc&name=
    }
    // limit=1&
    if (getFilesParams.desc != "") {
      url += 'desc=${getFilesParams.desc}&';
    }
    if (getFilesParams.name != "") {
      url += 'name=${getFilesParams.name}&';
    }
    if (getFilesParams.order != "") {
      url += 'order=${getFilesParams.order}';
    }
    dprint(url);
    return url;
  }

  static String getReportsUrl(GetReportsParams getReportsParams) {
    String url = "";
    if (getReportsParams.reportType.toLowerCase() == "file") {
      url =
          "files_log?page=${getReportsParams.page}&orderBy=${getReportsParams.order == 'createdAt' ? 'created_at' : getReportsParams.order}&action=${getReportsParams.action}&desc=${getReportsParams.desc}&file_key=${getReportsParams.key}";
    } else {
      url =
          "groups_log?limit=2&page=${getReportsParams.page}&orderBy=${getReportsParams.order == 'createdAt' ? 'created_at' : getReportsParams.order}&action=${getReportsParams.action}&desc=${getReportsParams.desc}&group_key=${getReportsParams.key}";
    }
    dprint(url);
    return url;
  }

  //endregion
}
