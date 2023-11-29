import 'package:equatable/equatable.dart';

class GroupModel extends Equatable {
  final int id;
  final String name;
  final String desc;
  final String groupKey;
  final String createdAt;
  final int files;
  final int contributers;

  const GroupModel(
      {required this.id,
      required this.name,
      required this.desc,
      required this.groupKey,
      required this.createdAt,
      required this.files,
      required this.contributers});

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        id: json['id'] ?? -1,
        name: json['name'],
        desc: json['desc'],
        groupKey: json['group_key'],
        createdAt: json['created_at'],
        files: json['files'] ?? -1,
        contributers: json['contributers'] ?? -1,
      );

  @override
  List<Object?> get props =>
      [id, name, desc, groupKey, createdAt, files, contributers];
}
