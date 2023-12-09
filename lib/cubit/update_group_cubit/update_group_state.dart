import 'package:equatable/equatable.dart';
import 'package:github_clone_flutter/domain/models/create_update_group_model.dart';
import 'package:github_clone_flutter/domain/models/group_model.dart';

abstract class UpdateGroupState extends Equatable{
  const UpdateGroupState();
  @override
  List<Object> get props => [];
}
class UpdateGroupStateInitial extends UpdateGroupState{}
class UpdateGroupStateLoading extends UpdateGroupState{}
class UpdateGroupStateLoaded extends UpdateGroupState{
  final CreateUpdateGroupModel createUpdateGroupModel;

  const UpdateGroupStateLoaded({required this.createUpdateGroupModel});
}
class UpdateGroupStateError extends UpdateGroupState{
  final String messageError;

  const UpdateGroupStateError({required this.messageError});

}