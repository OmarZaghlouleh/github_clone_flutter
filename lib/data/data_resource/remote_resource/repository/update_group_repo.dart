
import 'package:dartz/dartz.dart';

import '../../../../domain/models/group_model.dart';
import '../../../../domain/models/params/update_group_params.dart';
import '../../local_resource/shared_preferences.dart';
import '../api_handler/base_api_client.dart';
import '../links.dart';

class UpdateGroupRepoImpl {
  Future<Either<String, GroupModel>> updateGroup(
      {required UpdateGroupParams updateGroupParams})async {
    return await BaseApiClient.put<GroupModel>(
        url: '${Links.createGroup}/${LocalResource.sharedPreferences.getString(updateGroupParams.name)}',
        formData: updateGroupParams.toJson(),
        converter: (value) {
          return  GroupModel.fromJson(value["data"]);
        });
  }
}
