import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/service_locator_di.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/cubit/group/group_loading_more_cubit.dart';
import 'package:github_clone_flutter/cubit/users/users_loading_more_cubit.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/get_users_list_repo.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/groups_repo.dart';
import 'package:github_clone_flutter/domain/models/user_model.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());

  int page = 1;
  List<UserModel> loadedList = [];

  void reset() {
    page = 1;
    loadedList.clear();
  }

  Future<void> getAllUsers(
      {required String searchText,
      required BuildContext context,
      bool clear = false}) async {
    if (clear) {
      loadedList.clear();
      page = 1;
    }
    if (loadedList.isEmpty) emit(UsersLoading());

    if (loadedList.isNotEmpty) {
      BlocProvider.of<UsersLoadingMoreCubit>(context).toggle(true);
    }

    final result = await getIt<GetUsersListRepoImpl>()
        .getUsersList(pageKey: page, allUsers: true, searchText: searchText);

    result.fold((l) {
      showSnackBar(title: l, context: context, error: true);
    }, (r) {
      if (r.items.isNotEmpty) page++;
      loadedList.addAll(r.items);
      emit(UsersInitial());
      Future.delayed(Duration.zero);
      emit(UsersLoaded(users: loadedList));
      BlocProvider.of<UsersLoadingMoreCubit>(context).toggle(false);
    });
  }
}
