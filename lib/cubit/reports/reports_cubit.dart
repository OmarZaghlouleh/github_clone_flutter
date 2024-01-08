import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/service_locator_di.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/cubit/reports/filters/report_action_cubit.dart';
import 'package:github_clone_flutter/cubit/reports/filters/report_desc_cubit.dart';
import 'package:github_clone_flutter/cubit/reports/filters/report_order_cubit.dart';
import 'package:github_clone_flutter/cubit/reports/filters/report_type_cubit.dart';
import 'package:github_clone_flutter/cubit/reports/reports_loading_more_cubit.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/reports_repo.dart';
import 'package:github_clone_flutter/domain/models/params/get_reports_params.dart';
import 'package:github_clone_flutter/domain/models/report_model.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit() : super(ReportsInitial());
  int page = 1;
  List<ReportModel> loadedList = [];

  void reset() {
    page = 1;
    loadedList.clear();
  }

  Future<void> getReports(
      {required BuildContext context,
      required String key,
      bool clear = false}) async {
    if (clear) {
      loadedList.clear();
      page = 1;
    }
    if (loadedList.isEmpty) emit(ReportsLoading());

    if (loadedList.isNotEmpty) {
      BlocProvider.of<ReportsLoadingMoreCubit>(context).toggle(true);
    }

    final result = await getIt<ReportsRepo>().getReports(
      getReportsParams: GetReportsParams(
        page: page,
        reportType: BlocProvider.of<ReportTypeCubit>(context).state.name,
        action: BlocProvider.of<ReportActionCubit>(context).state?.name ?? "",
        order: BlocProvider.of<ReportOrderCubit>(context).state?.name ?? "",
        desc: BlocProvider.of<ReportDescCubit>(context).state?.name ?? "",
        key: key,
      ),
    );

    result.fold((l) {
      emit(ReportsError());
      showSnackBar(title: l, context: context, error: true);
    }, (r) {
      if (r.isNotEmpty) page++;
      loadedList.addAll(r);
      emit(ReportsInitial());
      Future.delayed(Duration.zero);
      emit(ReportsLoaded(loadedList));
      dprint("Length${loadedList.length} Length${r.length}");
      BlocProvider.of<ReportsLoadingMoreCubit>(context).toggle(false);
    });
  }
}
