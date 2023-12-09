import 'package:dio/dio.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';

class AddFilesToGroupParams {
  final String commit;
  final List<MultipartFile> filesArray;
  final List<String> filesDesc;
  final String groupKey;

  AddFilesToGroupParams(
      {required this.commit,
      required this.filesArray,
      required this.filesDesc,
      required this.groupKey});
  Map<String, dynamic> toJson() {


    return {
      "commit": commit,
      "files_array":  [filesArray] ,
      "files_desc":  [filesDesc] ,
      "group_key": groupKey,
    };
  }
}
