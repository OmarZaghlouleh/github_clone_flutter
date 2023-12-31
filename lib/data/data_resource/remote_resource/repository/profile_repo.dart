import 'package:dartz/dartz.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/links.dart';

import '../../../../domain/models/profile_model.dart';

class ProfileRepoImp {
  Future<Either<String, ProfileModel>> getProfile({required int id}) {
    return BaseApiClient.get<ProfileModel>(
        url: Links.baseUrl +
            ((id == -1) ? Links.userProfile : Links.otherUserProfile(id)),
        converter: (value) {
          return ProfileModel.fromJson(value["data"]);
        });
  }
}
