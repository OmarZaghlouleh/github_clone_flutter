import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/app_router.dart';
import 'package:github_clone_flutter/core/utils/service_locator_di.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/data/data_resource/local_resource/shared_preferences.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/auth_repo.dart';
import 'package:github_clone_flutter/presentation/screens/auth/auth_screen.dart';
import 'package:github_clone_flutter/presentation/screens/auth/controllers/sign_in_controllers.dart';
import 'package:github_clone_flutter/presentation/screens/auth/controllers/sign_up_controllers.dart';
part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  Future<void> logout(bool all, BuildContext context) async {
    emit(LogoutLoading());
    final result = all
        ? await getIt<AuthRepoImp>().logoutFromAll()
        : await getIt<AuthRepoImp>().logout();

    result.fold((l) {
      emit(LogoutError());
      showSnackBar(title: l, context: context, error: true);
    }, (r) {
      emit(LogoutDone());
      LocalResource.deleteUserData();
      // We should add these 2 functions because we disposed controllers after sign in/up
      SignInControllers.initControllers();
      SignUpControllers.initControllers();
      AppRouter.navigateReplacementTo(
          context: context, destination: const AuthScreen());
    });
  }
}
