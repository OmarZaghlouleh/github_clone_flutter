
import 'package:equatable/equatable.dart';

class ReplaceFileModel extends Equatable{
  final bool success;
  final int status;
  final String message;
  final List<dynamic> data;

  const ReplaceFileModel(
      {required this.success,
        required this.status,
        required this.message,
        required this.data});

  factory ReplaceFileModel.fromJson(Map<String, dynamic> json) =>
      ReplaceFileModel(
          success: json["success"],
          status: json["status"],
          message: json["message"],
          data: json["data"]);

  @override
  // TODO: implement props
  List<Object?> get props =>[success,status,message,data];
}