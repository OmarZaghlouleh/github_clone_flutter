import 'package:equatable/equatable.dart';

class AddFilesToGroupModel extends Equatable{
  final bool success;
  final int status;
  final String message;
  final List<dynamic> data;

  AddFilesToGroupModel(
      {required this.success,
      required this.status,
      required this.message,
      required this.data});

  factory AddFilesToGroupModel.fromJson(Map<String, dynamic> json) =>
      AddFilesToGroupModel(
          success: json["success"],
          status: json["status"],
          message: json["message"],
          data: json["data"]);

  @override
  // TODO: implement props
  List<Object?> get props =>[success,status,message,data];
}
