part of 'add_files_to_group_cubit.dart';
sealed class AddFilesToGroupState extends Equatable {
  const AddFilesToGroupState();

  @override
  List<Object> get props => [];
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
