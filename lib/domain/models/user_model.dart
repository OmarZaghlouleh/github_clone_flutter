
class UsersModel {
  late final List<UserModel> data;

  UsersModel({required this.data});

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    List<UserModel>data = <UserModel>[];
      json['data'].forEach((v) {
        data.add(UserModel.fromJson(v));
      });
      return UsersModel(data: data);
  }

}

class UserModel {
  int id;
  int role;
  String roleName;
  String accountName;
  String email;
  String firstName;
  String lastName;
  String img;
  String createdAt;
  int groupsCount;
  int commitsCount;
  int commitsThisYear;

  UserModel({required this.id,
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
    required this.commitsThisYear});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'],
        role: json['role'],
        roleName: json['role_name'],
        accountName: json['account_name'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        img: json['img'],
        createdAt: json['created_at'],
        groupsCount: json ['groups_count'],
        commitsCount: json['commits_count'],
        commitsThisYear: json['commits_this_year']);
  }

}
