import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/create_group_repo.dart';
import 'package:github_clone_flutter/domain/models/create_update_group_model.dart';
import 'package:github_clone_flutter/domain/models/params/create_group_params.dart';
import 'package:github_clone_flutter/presentation/screens/group/controllers/create_group_controllers.dart';

import '../../core/utils/app_router.dart';
import '../../core/utils/service_locator_di.dart';
import '../../core/utils/utils_functions.dart';
import '../../data/data_resource/local_resource/shared_preferences.dart';
import 'package:equatable/equatable.dart';
import '../../domain/models/group_model.dart';
import '../../presentation/screens/home/home_screen.dart';

part'./create_group_state.dart';
class CreateGroupCubit extends Cubit<CreateGroupState> {
  CreateGroupCubit() : super(CreateGroupStateInitial());

  Future<void> createGroup(
      {required CreateGroupParams createGroupParams,
      required BuildContext context}) async {
    emit(CreateGroupStateLoading());
    final result = await getIt<CreateGroupRepoImpl>().createGroup(
        createGroupParams: CreateGroupParams(
      name: createGroupParams.name,
      desc: createGroupParams.desc,
      usersList: createGroupParams.usersList,
    ));
    result.fold((l) {
      emit(CreateGroupStateError(messageError: l.toString()));
      showSnackBar(title: l, context: context, error: true);
    }, (r) async {
      await LocalResource.saveGroupData(r);
      emit(CreateGroupStateLoaded(createUpdateGroupModel: r));
      // ignore: use_build_context_synchronously
      AppRouter.navigateReplacementTo(
          context: context, destination: const HomeScreen());
      CreateGroupControllers.clearControllers();
    });
  }
}
