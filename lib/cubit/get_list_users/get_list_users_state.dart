import 'package:equatable/equatable.dart';
import 'package:github_clone_flutter/domain/models/user_model.dart';

abstract class GetListUsersState extends Equatable{
  const GetListUsersState();
  @override
  List<Object> get props => [];
}
class GetListUsersStateInitial extends GetListUsersState{}
class GetListUsersStateLoading extends GetListUsersState{}
class GetListUsersStateLoaded extends GetListUsersState{
  final UsersModel usersModel;

  const GetListUsersStateLoaded({required this.usersModel});
}
class GetListUsersStateError extends GetListUsersState{
  final String messageError;

  const GetListUsersStateError({required this.messageError});

}