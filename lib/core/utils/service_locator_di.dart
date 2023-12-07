import 'package:get_it/get_it.dart';
import 'package:github_clone_flutter/cubit/create_group/create_group_cubit.dart';
import 'package:github_clone_flutter/cubit/get_list_users/get_list_users_cubit.dart';
import 'package:github_clone_flutter/cubit/update_group_cubit/update_group_cubit.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/add_files_to_group_repo.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/auth_repo.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/create_group_repo.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/profile_repo.dart';
import '../../data/data_resource/remote_resource/repository/Update_group_repo.dart';
import '../../data/data_resource/remote_resource/repository/get_users_list_repo.dart';
import '../../data/data_resource/remote_resource/repository/groups_repo.dart';

final getIt = GetIt.instance;
void setUp() {
  getIt.registerLazySingleton<AuthRepoImp>(() => AuthRepoImp());
  getIt.registerLazySingleton<ProfileRepoImp>(() => ProfileRepoImp());
  getIt.registerLazySingleton<CreateGroupRepoImpl>(() => CreateGroupRepoImpl());
  getIt.registerLazySingleton<GetUsersListRepoImpl>(
      () => GetUsersListRepoImpl());
  getIt.registerLazySingleton<UpdateGroupRepoImpl>(() => UpdateGroupRepoImpl());
  getIt.registerFactory<GetListUsersCubit>(() => GetListUsersCubit());
  getIt.registerLazySingleton<GroupsRepoImp>(() => GroupsRepoImp());
  getIt.registerLazySingleton<AddFilesToGroupRepoImpl>(() =>AddFilesToGroupRepoImpl());

  // getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(getIt.get<ApiServices>()));
}
