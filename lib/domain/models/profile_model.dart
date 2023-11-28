import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final int id;
  final int role;
  final String roleName;
  final String accountName;
  final String email;
  final String firstName;
  final String lastName;
  final String img;
  final String createdAt;
  final int groupsCount;
  final int commitsCount;
  final int commitsThisYear;

  const ProfileModel({
    required this.id,
    required this.role,
    required this.roleName,
    required this.accountName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.img,
    required this.createdAt,
    required this.groupsCount,
    required this.commitsCount,
    required this.commitsThisYear,
  });

  factory ProfileModel.fromJson(Map json) => ProfileModel(
        id: json['id'],
        role: json['role'],
        roleName: json['role_name'],
        accountName: json['account_name'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        img: json['img'],
        createdAt: json['created_at'],
        groupsCount: json['groups_count'],
        commitsCount: json['commits_count'],
        commitsThisYear: json['commits_this_year'],
      );

  @override
  List<Object> get props => [
        id,
        role,
        roleName,
        accountName,
        email,
        firstName,
        lastName,
        img,
        createdAt,
        groupsCount,
        commitsCount,
        commitsThisYear
      ];
}
