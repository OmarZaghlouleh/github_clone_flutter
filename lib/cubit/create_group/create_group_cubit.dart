import 'dart:js';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_clone_flutter/cubit/create_group/create_group_state.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/create_group_repo.dart';
import 'package:github_clone_flutter/domain/models/params/create_group_params.dart';
import 'package:github_clone_flutter/presentation/screens/group/controllers/create_group_controllers.dart';

import '../../core/utils/app_router.dart';
import '../../core/utils/service_locator_di.dart';
import '../../data/data_resource/local_resource/shared_preferences.dart';
import '../../presentation/common_widgets/show_toast_widget.dart';
import '../../presentation/screens/home/home_screen.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  CreateGroupCubit() : super(CreateGroupStateInitial());

  Future<void> createGroup(
      {required CreateGroupParams createGroupParams,required BuildContext context}) async {
    emit(CreateGroupStateLoading());
    final result = await getIt<CreateGroupRepoImpl>().createGroup(
        createGroupParams: CreateGroupParams(
      name: createGroupParams.name,
      desc: createGroupParams.desc,
      usersList: createGroupParams.usersList,
    ));
    result.fold((l) => emit(CreateGroupStateError(messageError: l.toString())),
        (r)async {
      await LocalResource.saveGroupData(r);
      emit(CreateGroupStateLoaded(createGroupModel: r));
      // ignore: use_build_context_synchronously
      AppRouter.navigateRemoveTo(context: context, destination: const HomeScreen());
      CreateGroupControllers.clearControllers();

    });
  }
}
