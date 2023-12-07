import 'package:dartz/dartz.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/links.dart';
import 'package:github_clone_flutter/domain/models/params/get_reports_params.dart';
import 'package:github_clone_flutter/domain/models/report_model.dart';

class ReportsRepo {
  Future<Either<String, List<ReportModel>>> getReports(
      {required GetReportsParams getReportsParams}) {
    return BaseApiClient.get<List<ReportModel>>(
        url: Links.baseUrl + Links.getReportsUrl(getReportsParams),
        converter: (value) {
          return (value["data"]['items'] as List)
              .map((e) => ReportModel.fromJson(e))
              .toList();
        });
  }
}
