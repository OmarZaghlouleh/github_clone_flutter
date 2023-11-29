// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/app_router.dart';
import 'package:github_clone_flutter/core/utils/service_locator_di.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/data/data_resource/local_resource/shared_preferences.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/auth_repo.dart';
import 'package:github_clone_flutter/domain/models/params/sign_in_params.dart';
import 'package:github_clone_flutter/presentation/screens/auth/controllers/sign_in_controllers.dart';
import 'package:github_clone_flutter/presentation/screens/home/home_screen.dart';
part './sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  Future<void> signin({required BuildContext context}) async {
    emit(SignInLoading());
    final result = await getIt<AuthRepoImp>().signIn(
        signinParams: SigninParams(
            accountName:
                SignInControllers.accountNameTextController.text.trim(),
            password: SignInControllers.passwordTextController.text.trim(),
            cName: SignInControllers.fakeFieldController.text.trim()));
    result.fold((l) {
      emit(SignInError());

      showSnackBar(title: l, context: context, error: true);
    }, (r) async {
      //Save To Storage
      await LocalResource.saveUserData(r);
      emit(SignInLoaded());
      AppRouter.navigateReplacementTo(
          context: context, destination: const HomeScreen());

      SignInControllers.disposeControllers();
    });
  }
}
