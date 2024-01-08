import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/service_locator_di.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/cubit/files/files_loading_more_cubit.dart';
import 'package:github_clone_flutter/cubit/files/filters/file_desc_cubit.dart';
import 'package:github_clone_flutter/cubit/files/filters/file_order_cubit.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/files_repo.dart';
import 'package:github_clone_flutter/domain/models/file_model.dart';
import 'package:github_clone_flutter/domain/models/params/get_files_params.dart';

part 'all_files_state.dart';

class AllFilesCubit extends Cubit<AllFilesState> {
  AllFilesCubit() : super(AllFilesInitial());

  int page = 1;
  List<FileModel> loadedList = [];

  void reset() {
    page = 1;
    loadedList.clear();
  }

  Future<void> getAllFiles(
      {required String name,
      required BuildContext context,
      bool clear = false}) async {
    if (loadedList.isEmpty) emit(AllFilesLoading());
    if (clear) {
      loadedList.clear();
      page = 1;
    }

    if (loadedList.isNotEmpty) {
      BlocProvider.of<FilesLoadingMoreCubit>(context).toggle(true);
    }

    final result = await getIt<FilesRepoImp>().getAllFiles(
        getFilesParams: GetFilesParams(
            userId: -1,
            page: page,
            order: BlocProvider.of<FileOrderCubit>(context).state?.name ?? "",
            desc: BlocProvider.of<FileDescCubit>(context).state?.name ?? "",
            name: name,
            key: ''));

    result.fold((l) {
      showSnackBar(title: l, context: context, error: true);
    }, (r) {
      if (r.isNotEmpty) page++;
      loadedList.addAll(r);
      emit(AllFilesLoaded(loadedList));
      BlocProvider.of<FilesLoadingMoreCubit>(context).toggle(false);
    });
  }
}
