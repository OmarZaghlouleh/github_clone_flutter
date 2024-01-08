import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/files_repo.dart';
import 'package:github_clone_flutter/domain/models/file_model.dart';
import 'package:flutter/material.dart';
import 'package:github_clone_flutter/core/utils/strings_manager.dart';
import 'package:github_clone_flutter/domain/models/params/download_files_params.dart';
import 'package:github_clone_flutter/domain/models/params/get_files_params.dart';
import '../../core/utils/service_locator_di.dart';
import '../../core/utils/utils_functions.dart';
import 'package:universal_html/html.dart' as html;
part 'files_list_state.dart';

class FilesListCubit extends Cubit<FilesListState> {
  FilesListCubit() : super(FilesListInitial());
  //  List< FileModel>? filesList;
  // String FileErrorMessage = '';
  List<FileModel> filesList = [];
  List<String> selectedFilesListToDownload = [];
  Map<String, bool> selectedFilesMapToDownload = {};
  String selectedFileToDownload = "";
  int page = 1;
  reset() {
    page = 1;
    filesList = [];
    selectedFilesListToDownload = [];
    selectedFilesMapToDownload = {};
  }

  changeSelectedFileToDownload(
      String selectedFileToDownloadValue, bool boolValue) {
    selectedFilesMapToDownload[selectedFileToDownloadValue] = boolValue;
    emit(FilesListLoading());
    emit(FilesListLoaded(filesList, selectedFilesMapToDownload));
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
      emit(FilesListLoaded(filesList, selectedFilesMapToDownload));
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

  Future<void> deleteFile({
    required BuildContext context,
    required String fileKey,
  }) async {
    dprint("iiiiiiiiiiiiiiiiiiiiiiiddddddddddd   ");
    dprint(fileKey);
    final result = await getIt<FilesRepoImp>().deleteFile(fileKey: fileKey);
    result.fold((l) {
      showSnackBar(title: l, context: context, error: true);
    }, (r) {
      dprint("ssssssssssssssssssssss");
      dprint(r);
      dprint("aaaaaaaaaaaaaaaaaaaaa");
      filesList.removeWhere((element) => element.fileKey == fileKey);
      // selectedFilesMapToDownload.removeWhere((element) => element == fileKey);
      dprint(filesList);
      emit(FilesListLoading());

      emit(FilesListLoaded(filesList, selectedFilesMapToDownload));
      dprint(r);
    });
  }

  addToselectedFilesList() {
    selectedFilesListToDownload = [];
    selectedFilesMapToDownload.forEach((k, v) {
      if (v == true) {
        selectedFilesListToDownload.add(k);
      }
    });
  }

  Future<void> downloadFiles({
    required BuildContext context,
    // required String name,
  }) async {
    addToselectedFilesList();
    if (selectedFilesListToDownload.isEmpty) {
      showSnackBar(title: "No selected files", context: context, error: false);
      return;
    }
    final result = await getIt<FilesRepoImp>().downloadFiles(
        downloadFilesParams:
            DownloadFilesParams(filesKeys: selectedFilesListToDownload));

    result.fold((l) {
      showSnackBar(title: l, context: context, error: true);
    }, (r) {
      dprint("ssssssssssssssssssssss");
      dprint(r);
      try {
        // base64Encode is from dart:convert

        final base64 = base64Encode(r);

// Create the link with the file
// AnchorElement comes from the
        final anchor = html.AnchorElement(
            href: 'data:application/octet-stream;base64,$base64')
          ..target = 'blank';

// add the name and extension

        if (selectedFilesListToDownload.length == 1) {
          FileModel selectedFileModel = filesList.firstWhere((element) =>
              element.fileKey == selectedFilesListToDownload.first);
          anchor.download = '${selectedFileModel.name}.zip';
        } else {
          anchor.download = '${filesList.first.groupName}_files.zip';
          // anchor.download = 'main.dart';
        }

// add the anchor to the document body
        html.document.body?.append(anchor);

// trigger download
        anchor.click();

// remove the anchor
        anchor.remove();
        dprint(r);
      } catch (e) {
        dprint(e);
      }
    });
  }
}
