import 'package:equatable/equatable.dart';

class CreateGroupParams extends Equatable {
  final String name;
  final String desc;
  final List<int> usersList;

  const CreateGroupParams(
      {required this.name, required this.desc, required this.usersList});
  Map<String, dynamic> toJson() =>
      {"name": name, "desc": desc, "users_list": usersList};
  @override
  List<Object?> get props => [name, desc, usersList];
}
