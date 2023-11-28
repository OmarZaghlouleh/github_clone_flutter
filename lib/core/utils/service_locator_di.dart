import 'package:get_it/get_it.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/auth_repo.dart';

final getIt = GetIt.instance;
void setUp() {
  getIt.registerLazySingleton<AuthRepoImp>(() => AuthRepoImp());

  // getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(getIt.get<ApiServices>()));
}
