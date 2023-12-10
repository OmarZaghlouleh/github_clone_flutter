part of 'replace_file_cubit.dart';

@immutable
abstract class ReplaceFileState {}

class ReplaceFileInitialState extends ReplaceFileState {}
class ReplaceFileLoadingState extends ReplaceFileState{}
class ReplaceFileLoadedState extends ReplaceFileState{
  final ReplaceFileModel replaceFileModel ;

  ReplaceFileLoadedState({required this.replaceFileModel});

}
class ReplaceFileErrorState extends ReplaceFileState{
  final String messageError;

  ReplaceFileErrorState({required this.messageError});

}
class ReplaceFileStatePickedFile extends ReplaceFileState{
  final FilePickerResult? result;

  ReplaceFileStatePickedFile({required this.result});

}
