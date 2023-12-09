import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:github_clone_flutter/core/utils/service_locator_di.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/groups_repo.dart';
import 'package:github_clone_flutter/domain/models/user_model.dart';

part 'group_contributers_state.dart';

class GroupContributersCubit extends Cubit<GroupContributersState> {
  GroupContributersCubit() : super(GroupContributersInitial());

  int page = 1;
  final List<UserModel> loadedData = [];

  Future<void> getGroupContributers(
      {required String key,
      required BuildContext context,
      bool clear = false}) async {
    emit(GroupContributersLoading());
    if (clear) {
      page = 1;
      loadedData.clear();
    }
    final result = await getIt<GroupsRepoImp>().getGroupContributers(key: key);

    result.fold((l) {
      showSnackBar(title: l, context: context, error: true);
    }, (r) {
      if (r.isNotEmpty) page++;
      loadedData.addAll(r);
      emit(GroupContributersLoaded(loadedData));
    });
  }
}
