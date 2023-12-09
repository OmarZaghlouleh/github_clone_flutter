import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/replace_file_repo.dart';
import 'package:github_clone_flutter/domain/models/params/replace_file_params.dart';
import 'package:github_clone_flutter/domain/models/replace_file_model.dart';

import '../../core/utils/service_locator_di.dart';
import '../../core/utils/utils_functions.dart';
import '../../presentation/common_widgets/show_toast_widget.dart';
import '../../presentation/screens/files/widgets/upload_file_card_widget.dart';

part 'replace_file_state.dart';

class ReplaceFileCubit extends Cubit<ReplaceFileState> {
  FilePickerResult? result;

  UploadFileCardWidget uploadFileCardWidget =
      UploadFileCardWidget(description: TextEditingController(), index: 0,type: 'replace',);

  ReplaceFileCubit() : super(ReplaceFileInitialState());

  Future<void> replaceFile(
      {required ReplaceFileParams replaceFileParams,
      required BuildContext context})async {
    emit(ReplaceFileLoadingState());
    final response = await getIt<ReplaceFileRepoImpl>().replaceFile(replaceFileParams: replaceFileParams);
    response.fold((l) {
      uploadFileCardWidget.description!.clear();
      uploadFileCardWidget.file=null;
      result=null;
      Navigator.of(context).pop();
      showSnackBar(title: l.toString(), context: context);
      emit(ReplaceFileErrorState(messageError: l.toString()));
    }, (r) {
      uploadFileCardWidget.description!.clear();
      result = null;
      Navigator.of(context).pop();
      showToastWidget(r.message);
      emit(ReplaceFileLoadedState(replaceFileModel: r));
    });
  }

  Future<void> pickFile() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      withData: true,
    );
    uploadFileCardWidget.file = result;
    emit(ReplaceFileStatePickedFile(result: result));
  }

  Future<void> uploadFiles(
      {required String fileKey, required BuildContext context}) async {
    final file = MultipartFile.fromBytes(result!.files.first.bytes!,
        filename: "-${result!.files.first.name}");

    await BlocProvider.of<ReplaceFileCubit>(context).replaceFile(
        replaceFileParams: ReplaceFileParams(
            newFile: file,
            desc: uploadFileCardWidget.description!.text,
            fileKey: fileKey),
        context: context);
  }
}
