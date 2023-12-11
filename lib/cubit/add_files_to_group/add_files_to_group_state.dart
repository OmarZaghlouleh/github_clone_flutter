part of 'add_files_to_group_cubit.dart';
sealed class AddFilesToGroupState{
  const AddFilesToGroupState();

}

 class AddFilesToGroupStateInitial extends AddFilesToGroupState {}

 class AddFilesToGroupStateLoading extends AddFilesToGroupState {}

 class AddFilesToGroupStateLoaded extends AddFilesToGroupState {
  final AddFilesToGroupModel addFilesToGroupModel;

  const AddFilesToGroupStateLoaded({required this.addFilesToGroupModel});
}

 class AddFilesToGroupStateError extends AddFilesToGroupState {
  final String messageError;

 const AddFilesToGroupStateError({required this.messageError});
}
class AddFilesToGroupStatePickedFile extends AddFilesToGroupState{
  final FilePickerResult? result;
  final int index;

  AddFilesToGroupStatePickedFile({required this.result, required this.index});

}
