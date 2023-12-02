import 'package:dartz/dartz.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:github_clone_flutter/domain/models/user_model.dart';

import '../../local_resource/shared_preferences.dart';
import '../links.dart';

class GetUsersListRepoImpl {
  Future<Either<String, UsersModel>> getUsersList({required int pageKey}) {
    return BaseApiClient.get(
      url:  Links.getListUsers,
      queryParameters: {'page': pageKey},
      converter: (value) {

        return UsersModel.fromJson(value);
      },
    );
  }
}

