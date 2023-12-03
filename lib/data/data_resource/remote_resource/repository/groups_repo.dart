import 'package:dartz/dartz.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/links.dart';
import 'package:github_clone_flutter/domain/models/group_model.dart';
import 'package:github_clone_flutter/domain/models/params/get_groups_params.dart';

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
}
