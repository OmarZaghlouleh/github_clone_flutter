import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:github_clone_flutter/domain/models/params/get_groups_params.dart';

import '../../core/utils/service_locator_di.dart';
import '../../core/utils/utils_functions.dart';
import '../../data/data_resource/remote_resource/repository/groups_repo.dart';
import '../../domain/models/group_model.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit() : super(GroupInitial());
  //  List< GroupModel? group;
  // String GroupErrorMessage = '';
  Future<void> getGroup({
    required BuildContext context,
    required int page,
    required String order,
    required String desc,
    required String name,
  }) async {
    emit(GroupLoading());
    final result = await getIt<GroupsRepoImp>().getGroups(
        getGroupsParams:
            GetGroupsParams(page: page, order: order, desc: desc, name: name));
    result.fold((l) {
      // GroupErrorMessage = l;
      emit(GroupError(l));
      showSnackBar(title: l, context: context, error: true);
    }, (r) {
      // Group = r;
      emit(GroupLoaded(r));
    });
  }
}
