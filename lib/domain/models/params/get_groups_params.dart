// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class GetGroupsParams extends Equatable {
  final int page;

  final String order;
  final String desc;
  final String name;

  const GetGroupsParams(
      {required this.page,
      required this.order,
      required this.desc,
      required this.name});

  @override
  List<Object> get props {
    return [page, order, desc, name];
  }
}
