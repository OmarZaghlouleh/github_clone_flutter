import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/check_out_repo.dart';

import '../../core/utils/service_locator_di.dart';
import '../../domain/models/check_in_and_check_out_model.dart';
import '../../presentation/common_widgets/show_toast_widget.dart';

part 'check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit() : super(CheckOutInitialState());

  Future<void> checkOut(
      {required String fileKey, required BuildContext context}) async {
    emit(CheckOutLoadingState());
    final result = await getIt<CheckOutRepoImpl>().checkOut(fileKey: fileKey);
    result.fold((l) {
      showSnackBar(title: l.toString(), context: context);
      emit(CheckOutErrorState(messageError: l.toString()));
    }, (r) {
      showToastWidget('The file reservation has been successfully cancelled');
      emit(CheckOutLoadedState(checkInAndCheckOutModel: r));
    });
  }
}
