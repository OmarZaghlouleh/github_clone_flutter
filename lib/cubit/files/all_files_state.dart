part of 'all_files_cubit.dart';

sealed class AllFilesState extends Equatable {
  const AllFilesState();

  @override
  List<Object> get props => [];
}

final class AllFilesInitial extends AllFilesState {}

final class AllFilesLoading extends AllFilesState {}

final class AllFilesError extends AllFilesState {}

final class AllFilesLoaded extends AllFilesState {
  final List<FileModel> files;

  const AllFilesLoaded(this.files);
}
