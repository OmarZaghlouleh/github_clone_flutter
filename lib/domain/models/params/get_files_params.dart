import 'package:equatable/equatable.dart';

class GetFilesParams extends Equatable {
  final int page;

  final String order;
  final String desc;
  final String name;
  final String key;

  const GetFilesParams({
    required this.page,
    required this.order,
    required this.desc,
    required this.name,
    required this.key,
  });

  @override
  List<Object> get props {
    return [page, order, desc, name, key];
  }
}
