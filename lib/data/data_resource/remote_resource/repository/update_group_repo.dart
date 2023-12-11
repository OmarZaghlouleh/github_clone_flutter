import 'package:dartz/dartz.dart';
import 'package:github_clone_flutter/domain/models/create_update_group_model.dart';
import '../../../../domain/models/params/update_group_params.dart';
import '../../local_resource/shared_preferences.dart';
import '../api_handler/base_api_client.dart';
import '../links.dart';

class UpdateGroupRepoImpl {
  Future<Either<String, CreateUpdateGroupModel>> updateGroup(
      {required UpdateGroupParams updateGroupParams, required String groupKey}) async {
    return await BaseApiClient.put<CreateUpdateGroupModel>(
        url:
            '${Links.createGroup}/$groupKey',
        formData: updateGroupParams.toJson(),
        converter: (value) {
          return CreateUpdateGroupModel.fromJson(value["data"]);
        });
  }
}
