class CheckInParams{
  final List<String>filesKey;

  CheckInParams({required this.filesKey});
  Map<String,dynamic>toJson(){
    return {
    "files_keys":filesKey,
    };
  }

}