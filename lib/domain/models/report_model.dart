// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:github_clone_flutter/domain/models/user_model.dart';

class ReportModel extends Equatable {
  final int id;
  final String action;
  final String additionalInfo;
  final int importance;
  final String createdAt;
  final UserModel user;
  const ReportModel({
    required this.id,
    required this.action,
    required this.additionalInfo,
    required this.importance,
    required this.createdAt,
    required this.user,
  });

  factory ReportModel.fromJson(Map json) => ReportModel(
      id: json['id'] ?? -1,
      action: json['action'] ?? "",
      additionalInfo: json['additional_info'] ?? "",
      importance: json['importance'] ?? 0,
      createdAt: json['created_at'] ?? "",
      user: UserModel.fromJson(json['user'] ?? {}));
  @override
  List<Object> get props {
    return [
      id,
      action,
      additionalInfo,
      importance,
      createdAt,
      user,
    ];
  }
}
