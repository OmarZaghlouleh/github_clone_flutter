

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/cubit/update_group_cubit/update_group_state.dart';

import '../../core/utils/app_router.dart';
import '../../core/utils/service_locator_di.dart';
import '../../core/utils/utils_functions.dart';
import '../../data/data_resource/local_resource/shared_preferences.dart';
import '../../data/data_resource/remote_resource/repository/Update_group_repo.dart';
import '../../domain/models/params/update_group_params.dart';
import '../../presentation/screens/group/controllers/create_group_controllers.dart';
import '../../presentation/screens/home/home_screen.dart';

class UpdateGroupCubit extends Cubit<UpdateGroupState> {
  UpdateGroupCubit() : super(UpdateGroupStateInitial());

  Future<void> updateGroup(
      {required UpdateGroupParams updateGroupObject,
      required BuildContext context,required String groupKey}) async {
    emit(UpdateGroupStateLoading());
    final result = await getIt<UpdateGroupRepoImpl>()
        .updateGroup(updateGroupParams: updateGroupObject,groupKey:groupKey);
    result.fold((l) {
      emit(UpdateGroupStateError(messageError: l.toString()));
      showSnackBar(title: l, context: context, error: true);
      CreateGroupControllers.clearControllers();
    }, (r) async {
      await LocalResource.saveGroupData(r);
      emit(UpdateGroupStateLoaded(createUpdateGroupModel: r));

      // ignore: use_build_context_synchronously
      AppRouter.navigateReplacementTo(
          context: context, destination: const HomeScreen());
      CreateGroupControllers.clearControllers();
    });
  }
}
