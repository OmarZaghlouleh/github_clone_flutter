import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/check_in_repo.dart';
import 'package:github_clone_flutter/domain/models/params/check_in_params.dart';

import '../../core/utils/service_locator_di.dart';
import '../../domain/models/check_in_and_check_out_model.dart';

part 'check_in_state.dart';

class CheckInCubit extends Cubit<CheckInState> {
  CheckInCubit() : super(CheckInInitialState());

  Future<void> checkIn({required CheckInParams checkInParams}) async {
    emit(CheckInLoadingState());
    final result =
        await getIt<CheckInRepoImpl>().checkIn(checkInParams: checkInParams);
    result.fold((l) => emit(CheckInErrorState(messageError: l.toString())),
        (r) => CheckInLoadedState(checkInAndCheckOutModel: r));
  }
}
