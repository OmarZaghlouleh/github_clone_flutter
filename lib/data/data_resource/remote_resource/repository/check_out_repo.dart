import 'package:dartz/dartz.dart';

import '../../../../domain/models/check_in_and_check_out_model.dart';
import '../api_handler/base_api_client.dart';
import '../links.dart';

class CheckOutRepoImpl{
  Future<Either<String,CheckInAndCheckOutModel>>checkOut({required String fileKey})async{
    return   await BaseApiClient.post(
        url:  Links.checkOut+fileKey,
        converter: (value) {
          return CheckInAndCheckOutModel.fromJson(value);
        },
        );
  }
}