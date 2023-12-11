import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/add_files_to_group_repo.dart';
import 'package:github_clone_flutter/domain/models/params/add_files_to_group_params.dart';

import '../../core/utils/service_locator_di.dart';
import '../../domain/models/add_files_to_group_model.dart';
import '../../presentation/common_widgets/show_toast_widget.dart';
import '../../presentation/screens/files/controllers/upload_files_controllers.dart';
import '../../presentation/screens/files/widgets/upload_file_card_widget.dart';

part './add_files_to_group_state.dart';

class AddFilesToGroupCubit extends Cubit<AddFilesToGroupState> {
  List<FilePickerResult?> result = [null];
  List<UploadFileCardWidget> uploadFileCardWidgetList = [
    UploadFileCardWidget(description: TextEditingController(), index: 0,type: 'upload',)
  ];

  AddFilesToGroupCubit() : super(AddFilesToGroupStateInitial());

  Future<void> addFilesToGroupParams(
      {required AddFilesToGroupParams addFilesToGroupParams,
      required BuildContext context}) async {
    emit(AddFilesToGroupStateLoading());
    final response = await getIt<AddFilesToGroupRepoImpl>()
        .addFilesToGroup(addFilesToGroupParams: addFilesToGroupParams);
    response.fold((l) {
      uploadFileCardWidgetList.clear();
      UploadFilesControllers.commitController.clear();
      result.clear();
      result = [null];
      uploadFileCardWidgetList = [
        UploadFileCardWidget(description: TextEditingController(), index: 0,type: 'upload',)
      ];
      Navigator.of(context).pop();
      showSnackBar(title: l.toString(), context: context);
      emit(AddFilesToGroupStateError(messageError: l.toString()));
    }, (r) {
      uploadFileCardWidgetList.clear();
      UploadFilesControllers.commitController.clear();
      result.clear();
      result = [null];
      uploadFileCardWidgetList = [
        UploadFileCardWidget(description: TextEditingController(), index: 0,type: 'upload',)
      ];
      Navigator.of(context).pop();
      showToastWidget('The files have been added to the group successfully');
      emit(AddFilesToGroupStateLoaded(addFilesToGroupModel: r));
    });
  }

  Future<void> pickFile(int index) async {
    result[index] = await FilePicker.platform.pickFiles(
      type: FileType.any,
      withData: true,
    );
    uploadFileCardWidgetList[index].file = result[index];
    emit(AddFilesToGroupStatePickedFile(result: result[index], index: index));
  }

  Future<void> uploadFiles(
      {required String groupKey, required BuildContext context }) async {
    List<MultipartFile> filesArray = [];
    List<String> filesDescription = [];

    for (int i = 0; i < result.length; i++) {
      final file = result[i];
      filesArray.addAll(file!.files
          .map((e) => MultipartFile.fromBytes(e.bytes!, filename: "-${e.name}"))
          .toList());
    }

    uploadFileCardWidgetList
        .map((e) => filesDescription.add(e.description!.text))
        .toList();
    await BlocProvider.of<AddFilesToGroupCubit>(context).addFilesToGroupParams(
        addFilesToGroupParams: AddFilesToGroupParams(
            commit: UploadFilesControllers.commitController.text,
            filesArray: filesArray,
            filesDesc: filesDescription,
            groupKey: groupKey),
        context: context);
  }
}
