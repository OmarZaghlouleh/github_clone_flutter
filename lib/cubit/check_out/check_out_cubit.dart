import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/check_out_repo.dart';

import '../../core/utils/service_locator_di.dart';
import '../../domain/models/check_in_and_check_out_model.dart';

part 'check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit() : super(CheckOutInitialState());

  Future<void> checkOut({required String fileKey}) async {
    emit(CheckOutLoadingState());
    final result = await getIt<CheckOutRepoImpl>().checkOut(fileKey: fileKey);
    result.fold((l) => emit(CheckOutErrorState(messageError: l.toString())),
        (r) => emit(CheckOutLoadedState(checkInAndCheckOutModel: r)));
  }
}
