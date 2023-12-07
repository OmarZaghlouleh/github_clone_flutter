import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:github_clone_flutter/domain/models/add_files_to_group_model.dart';
import 'package:github_clone_flutter/domain/models/params/add_files_to_group_params.dart';

import '../links.dart';

class AddFilesToGroupRepoImpl {
  Future<Either<String, AddFilesToGroupModel>> addFilesToGroup(
      {required AddFilesToGroupParams addFilesToGroupParams}) async {
    return await BaseApiClient.post(
        url: Links.baseUrl + Links.addFilesToGroup,
        converter: (value) {
          return AddFilesToGroupModel.fromJson(value);
        },
        formData: FormData.fromMap(addFilesToGroupParams.toJson()));
  }
}
