import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_clone_flutter/core/utils/enums.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';

class ReportTypeCubit extends Cubit<Report> {
  ReportTypeCubit() : super(Report.group);

  void toggleType() {
    state == Report.file ? emit(Report.group) : emit(Report.file);
  }

  void changeType(Report type) {
    dlog("Changing To $type");
    emit(type);
  }
}
