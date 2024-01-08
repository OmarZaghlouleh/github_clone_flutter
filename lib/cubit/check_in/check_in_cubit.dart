import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/check_in_repo.dart';
import 'package:github_clone_flutter/domain/models/params/check_in_params.dart';
import 'package:github_clone_flutter/presentation/common_widgets/show_toast_widget.dart';

import '../../core/utils/service_locator_di.dart';
import '../../domain/models/check_in_and_check_out_model.dart';

part 'check_in_state.dart';

class CheckInCubit extends Cubit<CheckInState> {
  CheckInCubit() : super(CheckInInitialState());

  Map<int, Map<bool, String>> selectFileKeys = {};
  bool selectLongTab = false;

  Future<void> checkIn({required BuildContext context}) async {
    emit(CheckInLoadingState());
    final List<String> filesKey = [];
    for (int key in selectFileKeys.keys) {
      filesKey.add(selectFileKeys[key]![true]!);
    }

    final result = await getIt<CheckInRepoImpl>()
        .checkIn(checkInParams: CheckInParams(filesKey: filesKey));
    result.fold((l) {
      showSnackBar(title: l.toString(), context: context);
      selectFileKeys.clear();
      selectLongTab = false;
    emit(CheckInErrorState(messageError: l.toString()));
    },
        (r) {
      showToastWidget('Files have been reserved successfully');
         selectFileKeys.clear();
          selectLongTab = false;
          emit(CheckInInitialState());
          emit(CheckInLoadedState(checkInAndCheckOutModel: r));
        });
  }

  void checkSelectedOrNotSelected(
      {required bool selectFile, required int index, required String fileKey}) {
    if (selectFile) {
      if (index < selectFileKeys.length) {
        selectFileKeys[index] = {true: fileKey};
      } else {
        for (int i = selectFileKeys.length; i < index; i++) {
          selectFileKeys.putIfAbsent(i, () => {false: ""});
        }
        selectFileKeys.putIfAbsent(index, () => {true: fileKey});
      }

      emit(CheckInFile());
    } else {
      if (index == selectFileKeys.length - 1) {
        selectFileKeys.remove(index);
      } else {
        selectFileKeys.update(index, (value) => {false: ""});
      }
      emit(CheckOutFile());
    }
  }
}
