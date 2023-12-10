import 'package:equatable/equatable.dart';

class FileModel extends Equatable {
  final int id;
  final String name;
  final String desc;
  final String fileKey;
  final int groupId;
  final String groupName;
  final String reservedBy;
  final String reservedByName;
  final String size;
  final String type;
  final String createdAt;
  final String createdBy;
  final String lastUpdate;
  const FileModel(
      {required this.id,
        required this.name,
        required this.desc,
        required this.fileKey,
        required this.groupId,
        required this.groupName,
        required this.reservedBy,
        required this.reservedByName,
        required this.size,
        required this.type,
        required this.createdBy,
        required this.createdAt,
        required this.lastUpdate});

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
    id: json['id'] ?? 0,
    name: json['name'] ?? "",
    desc: json['desc'] ?? "",
    fileKey: json['file_key'] ?? "",
    groupId: json['group_id'] ?? 0,
    groupName: json['group_name'] ?? "",
    reservedBy: json['reserved_by'] ?? "",
    reservedByName: json['reserved_by_name'] ?? "",
    size: json['size'] ?? "",
    type: json['type'] ?? "",
    createdAt: json['created_at'] ?? "",
    createdBy: json['created_by'] ?? "",
    lastUpdate: json['last_update'] ?? "",
  );

  @override
  List<Object?> get props => [
    id,
    name,
    desc,
    fileKey,
    groupId,
    groupName,
    reservedBy,
    reservedByName,
    size,
    type,
    createdAt,
    lastUpdate
  ];
}