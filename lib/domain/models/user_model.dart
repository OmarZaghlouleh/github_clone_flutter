class UsersModel {
  late final List<UserModel> items;
  final int lastPage;
  final int total;
  final int perPage;
  final int currentPage;

  UsersModel(
      {required this.lastPage,
      required this.total,
      required this.perPage,
      required this.currentPage,
      required this.items});

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    List<UserModel> items = <UserModel>[];
    json['items'].forEach((v) {
      items.add(UserModel.fromJson(v));
    });
    return UsersModel(
        items: items,
        lastPage: json['last_page'],
        total: json['total'],
        perPage: json['perPage'],
        currentPage: json['currentPage']);
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

  UserModel(
      {required this.id,
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
    return UserModel(
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
        commitsThisYear: json['commits_this_year']);
  }
}
