import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String token;
  final int roleId;
  final String roleName;
  const AuthModel({
    required this.token,
    required this.roleId,
    required this.roleName,
  });

  factory AuthModel.fromJson(Map json) => AuthModel(
        token: json['token'] ?? "",
        roleId: json['user']['role'] ?? -1,
        roleName: json['user']['role_name'] ?? "",
      );

  @override
  List<Object> get props => [token, roleId, roleName];
}
