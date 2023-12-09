import 'package:bloc/bloc.dart';
import 'package:github_clone_flutter/core/utils/enums.dart';

class FileDescCubit extends Cubit<Desc?> {
  FileDescCubit() : super(null);

  void changeDesc({required Desc? desc}) {
    if (state == desc) {
      emit(null);
    } else {
      emit(desc);
    }
  }
}
