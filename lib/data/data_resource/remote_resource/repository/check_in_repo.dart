import 'package:dartz/dartz.dart';
import 'package:github_clone_flutter/domain/models/check_in_and_check_out_model.dart';
import 'package:github_clone_flutter/domain/models/params/check_in_params.dart';

import '../api_handler/base_api_client.dart';
import '../links.dart';

class CheckInRepoImpl{
  Future<Either<String,CheckInAndCheckOutModel>>checkIn({required CheckInParams checkInParams})async{
    return   await BaseApiClient.post(
        url:  Links.checkIn,
        converter: (value) {
          return CheckInAndCheckOutModel.fromJson(value);
        },
        formData: checkInParams.toJson());
  }
}