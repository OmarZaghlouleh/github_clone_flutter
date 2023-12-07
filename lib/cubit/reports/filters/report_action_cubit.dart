import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/enums.dart';
import 'package:github_clone_flutter/cubit/reports/reports_cubit.dart';

class ReportActionCubit extends Cubit<ActionType?> {
  ReportActionCubit() : super(null);

  void changeAction({required ActionType? actionType}) {
    if (state == actionType) {
      emit(null);
    } else {
      emit(actionType);
    }
  }
}
