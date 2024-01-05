import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/links.dart';
import 'package:github_clone_flutter/domain/models/params/sign_in_params.dart';
import 'package:github_clone_flutter/domain/models/params/sign_up_params.dart';
import 'package:github_clone_flutter/domain/models/auth_model.dart';

class AuthRepoImp {
  Future<Either<String, AuthModel>> signUp(
      {required SignupParams signUpParam}) {
    return BaseApiClient.post<AuthModel>(
        formData: FormData.fromMap(signUpParam.toJson()),
        url: Links.baseUrl + Links.register,
        converter: (value) {
          return AuthModel.fromJson(value["data"]);
        });
  }

  Future<Either<String, AuthModel>> signIn(
      {required SigninParams signinParams}) {
    return BaseApiClient.post<AuthModel>(
        formData: FormData.fromMap(signinParams.toJson()),
        url: Links.baseUrl + Links.login,
        converter: (value) {
          return AuthModel.fromJson(value["data"]);
        });
  }

  Future<Either<String, bool>> logout() {
    return BaseApiClient.get<bool>(
        url: Links.baseUrl + Links.logout,
        converter: (value) {
          return value['status'] == 200;
        });
  }

  Future<Either<String, bool>> logoutFromAll() {
    return BaseApiClient.get<bool>(
        url: Links.baseUrl + Links.logoutFromAll,
        converter: (value) {
          return value['status'] == 200;
        });
  }
}
