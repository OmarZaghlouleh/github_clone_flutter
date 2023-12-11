import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/links.dart';
import 'package:github_clone_flutter/domain/models/group_model.dart';
import 'package:github_clone_flutter/domain/models/params/get_groups_params.dart';
import 'package:github_clone_flutter/domain/models/user_model.dart';

class GroupsRepoImp {
  Future<Either<String, List<GroupModel>>> getGroups(
      {required GetGroupsParams getGroupsParams}) {
    return BaseApiClient.get<List<GroupModel>>(
        url: Links.baseUrl + Links.getGroups(getGroupsParams),
        converter: (value) {
          return List<GroupModel>.from(
              value["data"]["items"].map((x) => GroupModel.fromJson(x)));
        });
  }

  Future<Either<String, bool>> deleteGroup({required String groupKey}) {
    return BaseApiClient.delete<bool>(
        url: Links.baseUrl + Links.deleteGroup(groupKey),
        converter: (value) {
          return value["success"];
        });
  }

  Future<Either<String, dynamic>> cloneGroup({required String groupKey}) {
    return BaseApiClient.get<dynamic>(
        responseTypeValue: ResponseType.bytes,
        url: Links.baseUrl + Links.cloneGroup(groupKey),
        converter: (value) {
          return value;
        });
  }

  Future<Either<String, List<GroupModel>>> getAllGroups(
      {required GetGroupsParams getGroupsParams}) {
    return BaseApiClient.get<List<GroupModel>>(
        url: Links.baseUrl + Links.getAllGroupsUrl(getGroupsParams),
        converter: (value) {
          return List<GroupModel>.from(
              value["data"]["items"].map((x) => GroupModel.fromJson(x)));
        });
  }

  Future<Either<String, List<UserModel>>> getGroupContributers(
      {required String key, required int page}) {
    return BaseApiClient.get<List<UserModel>>(
        url: Links.baseUrl + Links.getGroupContributersUrl(key, page),
        converter: (value) {
          return List<UserModel>.from(
              value["data"]["items"].map((x) => UserModel.fromJson(x)));
        });
  }
}
