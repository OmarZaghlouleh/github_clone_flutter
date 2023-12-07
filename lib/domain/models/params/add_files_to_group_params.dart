import 'dart:io';

class AddFilesToGroupParams {
  final String commit;
  final List<File> filesArray;
  final List<String> filesDesc;
  final String groupKey;

  AddFilesToGroupParams(
      {required this.commit,
      required this.filesArray,
      required this.filesDesc,
      required this.groupKey});
  Map<String,dynamic>toJson()=>{
      "commit":commit,
    "files_array[]":filesArray,
    "files_desc[]":filesDesc,
    "group_key":groupKey,
    };

}
