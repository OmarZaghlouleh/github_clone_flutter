import 'package:equatable/equatable.dart';

class UpdateGroupParams extends Equatable{
  final String name;
  final String desc;
  final List<int> listUsers;
  final List<int> deletedUsersList;

  const UpdateGroupParams(
      {required this.name,
      required this.desc,
      required this.listUsers,
      required this.deletedUsersList});
 
  Map<String,dynamic> toJson()=>{
    "name":name,
    "desc":desc,
    "users_list":listUsers,
    "deleted_users_list":deletedUsersList,
  };
  @override
  // TODO: implement props
  List<Object?> get props =>[name, desc, listUsers, deletedUsersList];

}
