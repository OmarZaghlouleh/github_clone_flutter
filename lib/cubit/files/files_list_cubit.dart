import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/files_repo.dart';
import 'package:github_clone_flutter/domain/models/file_model.dart';
import 'package:flutter/material.dart';
import 'package:github_clone_flutter/core/utils/strings_manager.dart';
import 'package:github_clone_flutter/domain/models/params/get_files_params.dart';
import '../../core/utils/service_locator_di.dart';
import '../../core/utils/utils_functions.dart';
part 'files_list_state.dart';

class FilesListCubit extends Cubit<FilesListState> {
  FilesListCubit() : super(FilesListInitial());
  //  List< FileModel>? filesList;
  // String FileErrorMessage = '';
  List<FileModel> filesList = [];

  int page = 1;
  reset() {
    page = 1;
    filesList = [];
  }

  increasePages() {
    dprint("Paaaaaaaaaaaaaaaaaage");
    dprint(page);
    page++;
  }

  Future<void> getFilesList({
    required BuildContext context,
    required String order,
    required String desc,
    required String name,
    required String key,
    int userId = -1,
  }) async {
    if (state is FilesListLoading) {
      return;
    }
    dprint("naaaaaaaaaaame");
    dprint(name);
    emit(FilesListLoading());
    final result = await getIt<FilesRepoImp>().getFiles(
        getFilesParams: GetFilesParams(
            page: page,
            order: order,
            desc: desc,
            name: name,
            key: key,
            userId: userId));
    result.fold((l) {
      // FileErrorMessage = l;
      emit(FilesListError(l));
      showSnackBar(title: l, context: context, error: true);
    }, (r) {
      dprint("ssssssssssssssssssssss");
      dprint(filesList);
      dprint(r);
      // filesList = (state as FilesListLoaded).filesList;
      filesList.addAll(r);
      dprint("aaaaaaaaaaaaaaaaaaaaa");
      dprint(filesList);
      // filesList = r;
      emit(FilesListLoaded(filesList));
      dlog(r);
      dprint(r);
      if (r.isNotEmpty) {
        increasePages();
      } else {
        showSnackBar(
            title: StringManager.noOtherData, context: context, error: false);
      }
    });
  }
}
