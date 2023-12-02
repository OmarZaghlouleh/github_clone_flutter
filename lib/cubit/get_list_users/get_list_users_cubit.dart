import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:github_clone_flutter/core/utils/service_locator_di.dart';
import 'package:github_clone_flutter/cubit/get_list_users/get_list_users_state.dart';

import '../../data/data_resource/remote_resource/repository/get_users_list_repo.dart';
import '../../domain/models/user_model.dart';
class GetListUsersCubit extends Cubit<GetListUsersState> {
  GetListUsersCubit() : super(GetListUsersStateInitial());
  static Map<UserModel, bool> listUsersWithVariableBoolean={};
  static Map<UserModel,bool>listUsersDeletedFromGroup={};
  Future<void> getListUsers({required int pageKey}) async {
    try {
      emit(GetListUsersStateLoading());
      final result =
      await getIt<GetUsersListRepoImpl>().getUsersList(pageKey: pageKey);

      result.fold(
            (l) => emit(GetListUsersStateError(messageError: l.toString())),
            (r) {
              for (var item in r.data) {
                listUsersWithVariableBoolean[item] = false;
                listUsersDeletedFromGroup[item]=false;
              }
             return emit(GetListUsersStateLoaded(usersModel: r));
                  },
      );
    } catch (e) {
      emit(GetListUsersStateError(messageError: e.toString()));
    }
  }

}


