import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final int role;
  final String roleName;
  final String accountName;
  final String email;
  final String firstName;
  final String lastName;
  final String? img;
  final String createdAt;

  const UserModel({required this.id,
    required this.role,
    required this.roleName,
    required this.accountName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.img,
    required this.createdAt});

  factory UserModel.fromJson(Map<String, dynamic> json)=>
      UserModel(id: json["id"],
          role: json["role"],
          roleName: json["roleName"],
          accountName: json["accountName"],
          email: json["email"],
          firstName: json["firstName"],
          lastName: json["lastName"],
          img: json["img"]??"",
          createdAt: json["createdAt"]);

  Map<String, dynamic> toJason() =>
      {
        "id": id,
        "role": role,
        "roleName": roleName,
        "accountName": accountName,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "img": img,
        "createdAt": createdAt,
      };

  @override
  // TODO: implement props
  List<Object?> get props =>
      [
        id,
        role,
        roleName,
        accountName,
        email,
        firstName,
        lastName,
        img,
        createdAt
      ];
}

