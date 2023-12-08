import 'package:equatable/equatable.dart';
import 'package:github_clone_flutter/domain/models/profile_model.dart';

class CreateUpdateGroupModel extends Equatable {
  final int id;
  final String name;
  final String desc;
  final String groupKey;
  final String createdAt;
  final int numberFiles;
  final int numberContributers;
  final int numberCommits;
  final String lastCommit;
  final String lastCommitBy;

  const CreateUpdateGroupModel(
      {required this.id,
        required this.name,
        required this.desc,
        required this.groupKey,
        required this.createdAt,
        required this.numberFiles,
        required this.numberContributers,
        required this.numberCommits,
        required this.lastCommit,
        required this.lastCommitBy});

  factory CreateUpdateGroupModel.fromJson(Map<String, dynamic> json) => CreateUpdateGroupModel(
    id: json['id'] ?? -1,
    name: json['name'] ?? "",
    desc: json['desc'] ?? "",
    groupKey: json['group_key'] ?? "",
    createdAt: json['created_at'] ?? "",
    numberFiles: json['files'] ?? 0,
    numberContributers: json['contributers_count'],
    numberCommits: json['commits'] ?? 0,
    lastCommit: json['last_commit'] ?? "",
    lastCommitBy: json['last_commit_By'] ?? "",
  );

  @override
  List<Object?> get props => [
    id,
    name,
    desc,
    groupKey,
    createdAt,
    numberFiles,
    numberCommits,
    numberContributers,
    lastCommit,
    lastCommitBy
  ];
}
