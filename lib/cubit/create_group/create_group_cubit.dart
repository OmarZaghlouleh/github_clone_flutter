import 'package:bloc/bloc.dart';
import 'package:github_clone_flutter/cubit/create_group/create_group_state.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/create_group_repo.dart';
import 'package:github_clone_flutter/domain/models/params/create_group_params.dart';

import '../../core/utils/service_locator_di.dart';


class CreateGroupCubit extends Cubit<CreateGroupState> {
  CreateGroupCubit() : super(CreateGroupStateInitial());

  Future<void> createGroup(
      {required CreateGroupParams createGroupParams}) async {
    emit(CreateGroupStateLoading());
    final result = await getIt<CreateGroupRepoImpl>().createGroup(
        createGroupParams: CreateGroupParams(
      name: createGroupParams.name,
      desc: createGroupParams.desc,
      usersList: createGroupParams.usersList,
    ));
    result.fold((l) =>emit(CreateGroupStateError(messageError: l.toString())), (r) {
      emit(CreateGroupStateLoaded(createGroupModel: r));
    });
  }
}
