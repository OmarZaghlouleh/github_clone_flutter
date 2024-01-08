import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/domain/models/params/get_files_params.dart';
import 'package:github_clone_flutter/domain/models/params/get_reports_params.dart';

import '../../../domain/models/params/get_groups_params.dart';

abstract class Links {
  static const baseUrl =
      // "http://192.168.43.225:8000/api/";
      "http://192.168.43.113:8000/api/";

  static const baseUrlForImage =
      // "http://192.168.43.225:8000/api/";
      "http://192.168.43.113:8000/";

  //region auth
  static const register = "register";
  static const logout = "logout";
  static const logoutFromAll = "logoutAll";

  static const login = "login";
  static const userProfile = "profile";
  static otherUserProfile(int id) => "profile/$id";
  static const updateUserProfile = "update_profile";
  static const createGroup = "groups";
  static const getListUsers = "users";
  static const addFilesToGroup = "files";
  static const downloadFiles = "files/download";

  static const replaceFile = "files/replace";
  static const checkIn = "files/check";
  static const checkOut = "files/checkout/";
  static String getGroups(GetGroupsParams getGroupsParams) {
    String url = "";
    dprint("DDD: ${getGroupsParams.userId}");
    if (getGroupsParams.userId == -1) {
      url = "groups/user_groups?page=${getGroupsParams.page}&";
    } else {
      url =
          "groups/user_groups/${getGroupsParams.userId}?page=${getGroupsParams.page}&";
    }

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
      if (getFilesParams.userId == -1) {
        url = "files/user_files?page=${getFilesParams.page}&";
      } else {
        url =
            "files/user_files/${getFilesParams.userId}?page=${getFilesParams.page}&";
      }
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

  static deleteGroup(String key) => "groups/$key";
  static deleteFile(String fileKey) => "files/$fileKey";
  static cloneGroup(String key) => "groups/clone/$key";
  static String getReportsUrl(GetReportsParams getReportsParams) {
    String url = "";
    dprint("Typeee: ${getReportsParams.reportType}");
    if (getReportsParams.reportType.toLowerCase() == "file") {
      url =
          "files_log?page=${getReportsParams.page}&orderBy=${getReportsParams.order == 'createdAt' ? 'created_at' : getReportsParams.order}&action=${getReportsParams.action}&desc=${getReportsParams.desc}&file_key=${getReportsParams.key}";
    } else {
      url =
          "groups_log?page=${getReportsParams.page}&orderBy=${getReportsParams.order == 'createdAt' ? 'created_at' : getReportsParams.order}&action=${getReportsParams.action}&desc=${getReportsParams.desc}&group_key=${getReportsParams.key}";
    }
    dprint(url);
    return url;
  }

  static String getAllGroupsUrl(GetGroupsParams getGroupsParams) {
    return "groups?page=${getGroupsParams.page}&orderBy=${getGroupsParams.order == 'createdAt' ? 'created_at' : getGroupsParams.order}&desc=${getGroupsParams.desc}&name=${getGroupsParams.name}";
  }

  static String getGroupContributersUrl(String key, int page) {
    return "groups/group_contributers/$key?page=$page";
  }

  static String getAllFilesUrl(GetFilesParams getFilesParams) {
    return "files?page=${getFilesParams.page}&orderBy=${getFilesParams.order == 'createdAt' ? 'created_at' : getFilesParams.order}&desc=${getFilesParams.desc}&name=${getFilesParams.name}";
  }

  static String getUsers(String searchText) {
    return "users?search=$searchText";
  }

  //endregion
}
