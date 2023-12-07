part of 'add_files_to_group_cubit.dart';
sealed class AddFilesToGroupState extends Equatable {
  const AddFilesToGroupState();

  @override
  List<Object> get props => [];
}

final class AddFilesToGroupStateInitial extends AddFilesToGroupState {}

final class AddFilesToGroupStateLoading extends AddFilesToGroupState {}

final class AddFilesToGroupStateLoaded extends AddFilesToGroupState {
  final AddFilesToGroupModel addFilesToGroupModel;

  const AddFilesToGroupStateLoaded({required this.addFilesToGroupModel});
}

final class AddFilesToGroupStateError extends AddFilesToGroupState {
  final String messageError;

 const AddFilesToGroupStateError({required this.messageError});
}
