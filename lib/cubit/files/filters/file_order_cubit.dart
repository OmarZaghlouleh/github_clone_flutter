import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_clone_flutter/core/utils/enums.dart';

class FileOrderCubit extends Cubit<Order?> {
  FileOrderCubit() : super(null);

  void changeOrder({required Order? order}) {
    if (state == order) {
      emit(null);
    } else {
      emit(order);
    }
  }
}
