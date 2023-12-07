// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class GetReportsParams extends Equatable {
  final String reportType;
  final String action;
  final String order;
  final String desc;
  final String key;
  final int page;
  const GetReportsParams({
    required this.reportType,
    required this.action,
    required this.order,
    required this.desc,
    required this.key,
    required this.page,
  });

  @override
  List<Object> get props {
    return [
      reportType,
      action,
      order,
      desc,
      key,
      page,
    ];
  }
}
