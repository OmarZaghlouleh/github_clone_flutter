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
  String fullName;
  String img;
  String createdAt;
  String lastContributionAt;
  int groupsCount;
  int commitsCount;
  int commitsThisYear;
  int contributionsNumber;

  UserModel(
      {required this.id,
      required this.role,
      required this.roleName,
      required this.accountName,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.fullName,
      required this.img,
      required this.createdAt,
      required this.groupsCount,
      required this.commitsCount,
      required this.contributionsNumber,
      required this.lastContributionAt,
      required this.commitsThisYear});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'] ?? -1,
        role: json['role'] ?? -1,
        roleName: json['role_name'] ?? "",
        accountName: json['account_name'] ?? "",
        email: json['email'] ?? "",
        firstName: json['first_name'] ?? "",
        lastName: json['last_name'] ?? "",
        fullName: json['full_name'] ?? "",
        img: json['img'] ?? "",
        createdAt: json['created_at'] ?? "",
        groupsCount: json['groups_count'] ?? 0,
        commitsCount: json['commits_count'] ?? 0,
        contributionsNumber: json['number_of_contributions'] ?? 0,
        lastContributionAt: json['last_contribution_at'] ?? 0,
        commitsThisYear: json['commits_this_year'] ?? 0);
  }

  // factory UserModel.empty() => UserModel(
  //     id: -1,
  //     role: -1,
  //     roleName: "",
  //     accountName: "",
  //     email: "",
  //     firstName: "",
  //     lastName: "",
  //     img: "",
  //     createdAt: "",
  //     groupsCount: 0,
  //     commitsCount: 0,
  //     commitsThisYear: 0);
}
