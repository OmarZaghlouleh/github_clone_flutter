import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/profile_repo.dart';

import '../../core/utils/service_locator_di.dart';
import '../../core/utils/utils_functions.dart';
import '../../domain/models/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  ProfileModel? profile;
  // String profileErrorMessage = '';
  Future<void> getProfile(
      {required BuildContext context, required int id}) async {
    emit(ProfileLoading());
    final result = await getIt<ProfileRepoImp>().getProfile(id: id);
    result.fold((l) {
      // profileErrorMessage = l;
      emit(ProfileError(l));
      showSnackBar(title: l, context: context, error: true);
    }, (r) {
      profile = r;
      emit(ProfileLoaded(r));
    });
  }
}
