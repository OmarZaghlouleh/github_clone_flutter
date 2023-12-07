import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_clone_flutter/core/utils/enums.dart';

class ReportOrderCubit extends Cubit<Order?> {
  ReportOrderCubit() : super(null);

  void changeOrder({required Order? order}) {
    if (state == order) {
      emit(null);
    } else {
      emit(order);
    }
  }
}
