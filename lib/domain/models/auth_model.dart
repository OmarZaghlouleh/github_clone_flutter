import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String token;
  final int roleId;
  final int userId;
  final String roleName;
  const AuthModel({
    required this.token,
    required this.roleId,
    required this.roleName,
    required this.userId,
  });

  factory AuthModel.fromJson(Map json) => AuthModel(
        token: json['token'] ?? "",
        roleId: json['user']['role'] ?? -1,
        roleName: json['user']['role_name'] ?? "",
        userId: json['user']['id'] ?? -1,
      );

  @override
  List<Object> get props => [token, roleId, roleName, userId];
}
