import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/add_files_to_group_repo.dart';
import 'package:github_clone_flutter/domain/models/params/add_files_to_group_params.dart';

import '../../core/utils/service_locator_di.dart';
import '../../domain/models/add_files_to_group_model.dart';

part './add_files_to_group_state.dart';

class AddFilesToGroupCubit extends Cubit<AddFilesToGroupState> {
  AddFilesToGroupCubit() : super(AddFilesToGroupStateInitial());
  Future<void> addFilesToGroupParams(
      {required AddFilesToGroupParams addFilesToGroupParams}) async {
    emit(AddFilesToGroupStateLoading());
    final result = await getIt<AddFilesToGroupRepoImpl>()
        .addFilesToGroup(addFilesToGroupParams: addFilesToGroupParams);
    result.fold(
        (l) => emit(AddFilesToGroupStateError(messageError: l.toString())),
        (r) => emit(AddFilesToGroupStateLoaded(addFilesToGroupModel: r)));
  }
}
