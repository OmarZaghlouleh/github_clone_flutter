import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/strings_manager.dart';
import 'package:github_clone_flutter/domain/models/params/get_groups_params.dart';
import '../../core/utils/service_locator_di.dart';
import '../../core/utils/utils_functions.dart';
import '../../data/data_resource/remote_resource/repository/groups_repo.dart';
import '../../domain/models/group_model.dart';
part 'my_groups_state.dart';

class MyGroupsCubit extends Cubit<MyGroupsState> {
  MyGroupsCubit() : super(MyGroupsInitial());
  //  List< GroupModel? group;
  // String GroupErrorMessage = '';
  List<GroupModel> myGroups = [];

  int page = 1;
  reset() {
    page = 1;
    myGroups = [];
  }

  increasePages() {
    dprint("Paaaaaaaaaaaaaaaaaage");
    dprint(page);
    page++;
  }

  Future<void> getMyGroups({
    required BuildContext context,
    required String order,
    required String desc,
    required String name,
  }) async {
    if (state is MyGroupsLoading) {
      return;
    }
    dprint("naaaaaaaaaaame");
    dprint(name);
    emit(MyGroupsLoading());
    final result = await getIt<GroupsRepoImp>().getGroups(
        getGroupsParams:
            GetGroupsParams(page: page, order: order, desc: desc, name: name));
    result.fold((l) {
      // GroupErrorMessage = l;
      emit(MyGroupsError(l));
      showSnackBar(title: l, context: context, error: true);
    }, (r) {
      dprint("ssssssssssssssssssssss");
      dprint(myGroups);
      dprint(r);
      // myGroups = (state as MyGroupsLoaded).myGroups;
      myGroups.addAll(r);
      dprint("aaaaaaaaaaaaaaaaaaaaa");
      dprint(myGroups);
      // Group = r;
      emit(MyGroupsLoaded(myGroups));
      dlog(r);
      dprint(r);
      if (r.isNotEmpty) {
        increasePages();
      } else {
        showSnackBar(
            title: StringManager.noOtherData, context: context, error: false);
      }
    });
  }
}
