import 'package:equatable/equatable.dart';
import 'package:github_clone_flutter/domain/models/create_group_model.dart';

abstract class CreateGroupState extends Equatable{
  const CreateGroupState();
  @override
  List<Object> get props => [];
}
class CreateGroupStateInitial extends CreateGroupState{}
class CreateGroupStateLoading extends CreateGroupState{}
class CreateGroupStateLoaded extends CreateGroupState{
  final CreateGroupModel createGroupModel;

  const CreateGroupStateLoaded({required this.createGroupModel});
}
class CreateGroupStateError extends CreateGroupState{
  final String messageError;

 const CreateGroupStateError({required this.messageError});

}