part of 'files_list_cubit.dart';

sealed class FilesListState extends Equatable {
  const FilesListState();

  @override
  List<Object> get props => [];
}

final class FilesListInitial extends FilesListState {}

final class FilesListLoading extends FilesListState {}

final class FilesListError extends FilesListState {
  final String filesListErrorMessage;
  const FilesListError(this.filesListErrorMessage);
}

class FilesListLoaded extends FilesListState {
  List<FileModel> filesList = [];
  Map<String, bool> selectedFilesMapToDownload = {};

  FilesListLoaded(this.filesList, this.selectedFilesMapToDownload);
  // FilesListLoaded(List<FileModel> newfiles) {
  //   filesList.addAll(newfiles);
  // }
}
