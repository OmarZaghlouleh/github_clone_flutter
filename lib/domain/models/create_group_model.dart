import 'package:equatable/equatable.dart';
class CreateGroupModel extends Equatable {
  final int id;
  final String name;
  final String desc;
  final String groupKey;
  final String createdAt;
  final int numberFiles;
  final int numberContributers;


  const CreateGroupModel({required this.id,
    required this.name,
    required this.desc,
    required this.groupKey,
    required this.createdAt,
    required this.numberFiles,
    required this.numberContributers,
    });

  factory CreateGroupModel.fromJson(Map<String, dynamic> json) {
    return CreateGroupModel(id: json['id'],
      name: json['name'],
      desc: json['desc'],
      groupKey: json['group_key'],
      createdAt: json['created_at'],
      numberFiles: json['files'],
      numberContributers: json['contributers'],);
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [
        id,
        name,
        desc,
        groupKey,
        createdAt,
        numberFiles,
        numberContributers,

      ];
}
