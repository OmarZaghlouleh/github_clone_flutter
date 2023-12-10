import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:github_clone_flutter/domain/models/params/replace_file_params.dart';
import 'package:github_clone_flutter/domain/models/replace_file_model.dart';

import '../api_handler/base_api_client.dart';
import '../links.dart';

class ReplaceFileRepoImpl{
  Future<Either<String,ReplaceFileModel>>replaceFile({required ReplaceFileParams replaceFileParams})async{
    return   await BaseApiClient.post(
        url:  Links.replaceFile,
        converter: (value) {
          return ReplaceFileModel.fromJson(value);
        },
        formData: FormData.fromMap(replaceFileParams.toJson()));
  }
}