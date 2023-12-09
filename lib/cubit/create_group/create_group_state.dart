
part of 'create_group_cubit.dart';


abstract class CreateGroupState extends Equatable{
  const CreateGroupState();
  @override
  List<Object> get props => [];
}
class CreateGroupStateInitial extends CreateGroupState{}
class CreateGroupStateLoading extends CreateGroupState{}
class CreateGroupStateLoaded extends CreateGroupState{
  final CreateUpdateGroupModel createUpdateGroupModel;

  const CreateGroupStateLoaded({required this.createUpdateGroupModel});
}
class CreateGroupStateError extends CreateGroupState{
  final String messageError;

 const CreateGroupStateError({required this.messageError});

}