import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:github_clone_flutter/domain/models/create_group_model.dart';
import 'package:github_clone_flutter/domain/models/params/create_group_params.dart';

import '../links.dart';

class CreateGroupRepoImpl {
  Future<Either<String, CreateGroupModel>> createGroup(
      {required CreateGroupParams createGroupParams}) {
    return BaseApiClient.post<CreateGroupModel>(
        url: Links.baseUrl + Links.createGroup,
        formData: FormData.fromMap(createGroupParams.toJson()),
        converter: (value) {
          CreateGroupModel.fromJson(value["data"]);
        });
  }
}
