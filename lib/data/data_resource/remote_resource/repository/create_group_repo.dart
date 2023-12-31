import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:github_clone_flutter/domain/models/create_update_group_model.dart';
import 'package:github_clone_flutter/domain/models/group_model.dart';
import 'package:github_clone_flutter/domain/models/params/create_group_params.dart';

import '../links.dart';

class CreateGroupRepoImpl {
  Future<Either<String, CreateUpdateGroupModel>> createGroup(
      {required CreateGroupParams createGroupParams}) async {
    return await BaseApiClient.post<CreateUpdateGroupModel>(
        url: Links.createGroup,
        formData: createGroupParams.toJson(),
        converter: (value) {
          return CreateUpdateGroupModel.fromJson(value["data"]);
        });
  }
}
