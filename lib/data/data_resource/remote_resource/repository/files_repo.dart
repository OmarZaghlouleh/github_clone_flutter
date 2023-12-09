import 'package:dartz/dartz.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/links.dart';
import 'package:github_clone_flutter/domain/models/file_model.dart';
import 'package:github_clone_flutter/domain/models/params/get_files_params.dart';

class FilesRepoImp {
  Future<Either<String, List<FileModel>>> getFiles(
      {required GetFilesParams getFilesParams}) {
    return BaseApiClient.get<List<FileModel>>(
        url: Links.baseUrl + Links.getFiles(getFilesParams),
        converter: (value) {
          return List<FileModel>.from(
              value["data"]["items"].map((x) => FileModel.fromJson(x)));
        });
  }

  Future<Either<String, bool>> deleteFile({required String fileKey}) {
    return BaseApiClient.delete<bool>(
        url: Links.baseUrl + Links.deleteFile(fileKey),
        converter: (value) {
          return value["success"];
        });
  }
}
