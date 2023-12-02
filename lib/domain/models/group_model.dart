import 'package:equatable/equatable.dart';

class GroupModel extends Equatable {
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

  const GroupModel(
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

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
        id: json['id'],
        name: json['name'],
        desc: json['desc'],
        groupKey: json['group_key'],
        createdAt: json['created_at'],
        numberFiles: json['files'],
        numberContributers: json['contributers'],
        numberCommits: json['commits'],
        lastCommit: json['last_commit'],
        lastCommitBy: json['last_commit_By']);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        desc,
        groupKey,
        createdAt,
        numberFiles,
        numberContributers,
        numberCommits,
        lastCommit,
        lastCommitBy
      ];
}
