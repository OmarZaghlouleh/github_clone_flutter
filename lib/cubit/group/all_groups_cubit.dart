import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/service_locator_di.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/cubit/group/filters/group_desc_cubit.dart';
import 'package:github_clone_flutter/cubit/group/filters/group_order_cubit.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/groups_repo.dart';
import 'package:github_clone_flutter/domain/models/group_model.dart';
import 'package:github_clone_flutter/domain/models/params/get_groups_params.dart';

part 'all_groups_state.dart';

class AllGroupsCubit extends Cubit<AllGroupsState> {
  AllGroupsCubit() : super(AllGroupsInitial());

  int page = 1;
  List<GroupModel> loadedList = [];

  Future<void> getAllGroups(
      {required String name,
      required BuildContext context,
      bool clear = false}) async {
    emit(AllGroupsLoading());
    if (clear) {
      loadedList.clear();
      page = 1;
    }

    final result = await getIt<GroupsRepoImp>().getAllGroups(
        getGroupsParams: GetGroupsParams(
            userId: -1,
            page: page,
            order: BlocProvider.of<GroupOrderCubit>(context).state?.name ?? "",
            desc: BlocProvider.of<GroupDescCubit>(context).state?.name ?? "",
            name: name));

    result.fold((l) {
      showSnackBar(title: l, context: context, error: true);
    }, (r) {
      if (r.isNotEmpty) page++;
      loadedList.addAll(r);
      emit(AllGroupsLoaded(loadedList));
    });
  }
}
