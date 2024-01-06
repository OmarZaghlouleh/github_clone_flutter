import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';

class FilesLoadingMoreCubit extends Cubit<bool> {
  FilesLoadingMoreCubit() : super(false);

  void toggle(bool state) {
    if (this.state != state) emit(state);
  }
}
