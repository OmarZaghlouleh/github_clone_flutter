import 'package:bloc/bloc.dart';
import 'package:github_clone_flutter/core/utils/enums.dart';

class GroupDescCubit extends Cubit<Desc?> {
  GroupDescCubit() : super(null);

  void changeDesc({required Desc? desc}) {
    if (state == desc) {
      emit(null);
    } else {
      emit(desc);
    }
  }
}
