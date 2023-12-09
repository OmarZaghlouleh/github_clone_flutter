import 'package:dio/dio.dart';

class ReplaceFileParams {
  final MultipartFile newFile;
  final String desc;
  final String fileKey;

  ReplaceFileParams(
      {required this.newFile, required this.desc, required this.fileKey});
  Map<String, dynamic> toJson() {


    return {
      "file_key": fileKey,
      "desc":  desc,
      "new_file":  newFile,
    };
  }
}
