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
    Map<String, dynamic> json = {};
    json = {
      "commit": commit,
      "group_key": groupKey,
    };

    json.addEntries(
      filesArray
          .map((e) => MapEntry('files_array[${filesArray.indexOf(e)}]', e))
          .toList(),
    );
    json.addEntries(
      filesDesc
          .map((e) => MapEntry('files_desc[${filesDesc.indexOf(e)}]', e))
          .toList(),
    );

    return json;
  }
}
