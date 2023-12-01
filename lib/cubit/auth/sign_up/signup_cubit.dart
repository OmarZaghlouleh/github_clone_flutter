import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/app_router.dart';
import 'package:github_clone_flutter/core/utils/service_locator_di.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/cubit/auth/sign_up/signup_profile_image_cubit.dart';
import 'package:github_clone_flutter/data/data_resource/local_resource/shared_preferences.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/auth_repo.dart';
import 'package:github_clone_flutter/domain/models/params/sign_up_params.dart';
import 'package:github_clone_flutter/presentation/screens/auth/controllers/sign_up_controllers.dart';
import 'package:github_clone_flutter/presentation/screens/home/home_screen.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  Future<void> signup({required BuildContext context}) async {
    emit(SignupLoading());
    final result = await getIt<AuthRepoImp>().signUp(
      signUpParam: SignupParams(
        fileName: BlocProvider.of<SignupProfileImageCubit>(context).fileName,
        profileImage:
            BlocProvider.of<SignupProfileImageCubit>(context).fileImage,
        firstName: SignUpControllers.firstNameTextController.text.trim(),
        lastName: SignUpControllers.lastNameTextController.text.trim(),
        accountName: SignUpControllers.accountNameTextController.text.trim(),
        email: SignUpControllers.emailTextController.text.trim(),
        password: SignUpControllers.passwordTextController.text.trim(),
        confirmPassword:
            SignUpControllers.confirmPasswordTextController.text.trim(),
        cName: SignUpControllers.fakeFieldController.text.trim(),
      ),
    );
    result.fold((l) {
      emit(SignupError());

      showSnackBar(title: l, context: context, error: true);
    }, (r) {
      //Save To Storage
      LocalResource.saveUserData(r);
      emit(SignupLoaded());

      AppRouter.navigateReplacementTo(
          context: context, destination: const HomeScreen());

      SignUpControllers.disposeControllers();
    });
  }
}
