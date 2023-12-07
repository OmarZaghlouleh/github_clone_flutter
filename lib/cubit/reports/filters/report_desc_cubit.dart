import 'package:bloc/bloc.dart';
import 'package:github_clone_flutter/core/utils/enums.dart';

class ReportDescCubit extends Cubit<Desc?> {
  ReportDescCubit() : super(null);

  void changeDesc({required Desc? desc}) {
    if (state == desc) {
      emit(null);
    } else {
      emit(desc);
    }
  }
}
