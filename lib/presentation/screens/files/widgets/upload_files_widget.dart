import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/cubit/add_files_to_group/add_files_to_group_cubit.dart';
import 'package:github_clone_flutter/cubit/replace_file_cubit/replace_file_cubit.dart';
import 'package:github_clone_flutter/presentation/common_widgets/custom_text_form_field.dart';
import 'package:github_clone_flutter/presentation/screens/files/controllers/upload_files_controllers.dart';
import 'package:github_clone_flutter/presentation/screens/files/widgets/upload_file_card_widget.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';

import '../../../../core/utils/service_locator_di.dart';
import '../../../common_widgets/loader.dart';

class UploadFileWidget extends StatefulWidget {
  final String Key;
  final String type;

  const UploadFileWidget({super.key, required this.Key, required this.type});

  @override
  UploadFileWidgetState createState() => UploadFileWidgetState();
}

class UploadFileWidgetState extends State<UploadFileWidget> {
  @override
  Widget build(BuildContext context) {
    final AddFilesToGroupCubit addFilesToGroupCubit =
        BlocProvider.of<AddFilesToGroupCubit>(context);
    final ReplaceFileCubit replaceFileCubit =
        BlocProvider.of<ReplaceFileCubit>(context);
    return Dialog(
      child: Padding(
        padding: EdgeInsets.only(
          top: 0.1.mqHeight(context),
          bottom: 0.1.mqHeight(context),
          right: 0.2.mqWidth(context),
          left: 0.2.mqWidth(context),
        ),
        child: Column(
          children: [
            if (widget.type == 'upload')
              CustomTextFormField(
                label: 'add commit',
                textInputType: TextInputType.text,
                controller: UploadFilesControllers.commitController,
                maxLines: null,
                minLines: 2,
              ),
            SizedBox(height: 0.05.mqHeight(context)),
            Container(
              height: 0.4.mqHeight(context),
              width: 0.53.mqWidth(context),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.darkGrey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
              child: widget.type == "upload"
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: BlocBuilder<AddFilesToGroupCubit,
                              AddFilesToGroupState>(
                            builder: (context, state) {
                              return ListView.builder(
                                itemCount: addFilesToGroupCubit
                                    .uploadFileCardWidgetList.length,
                                itemBuilder: (context, index) =>
                                    UploadFileCardWidget(
                                  index: addFilesToGroupCubit
                                      .uploadFileCardWidgetList[index].index,
                                  description: addFilesToGroupCubit
                                      .uploadFileCardWidgetList[index]
                                      .description,
                                  file: addFilesToGroupCubit
                                      .uploadFileCardWidgetList[index].file,
                                      type: 'upload',
                                ),
                              );
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            int newIndexFile = addFilesToGroupCubit
                                .uploadFileCardWidgetList.length;
                            addFilesToGroupCubit.result.add(null);
                            addFilesToGroupCubit.uploadFileCardWidgetList
                                .add(UploadFileCardWidget(
                              index: newIndexFile,
                              description: TextEditingController(),
                              file: null,
                              type: 'upload',
                            ));
                            addFilesToGroupCubit
                                .emit(AddFilesToGroupStateInitial());
                          },
                          icon: const Icon(Icons.add),
                        )
                      ],
                    )
                  : UploadFileCardWidget(
                      description:
                          replaceFileCubit.uploadFileCardWidget.description,
                      file: replaceFileCubit.uploadFileCardWidget.file,
                type: 'replace',
                    ),
            ),

            const SizedBox(height: 20),
            // a button to upload the file
            widget.type == 'upload'
                ? BlocBuilder<AddFilesToGroupCubit, AddFilesToGroupState>(
                    builder: (context, state) {
                      if (state is AddFilesToGroupStateLoading) {
                        return const Loader();
                      }
                      return ElevatedButton(
                        onPressed: () {
                          addFilesToGroupCubit.uploadFiles(
                            context: context,
                            groupKey: widget.Key,
                          );
                        },
                        child: const Text('Upload'),
                      );
                    },
                  )
                : BlocBuilder<ReplaceFileCubit, ReplaceFileState>(
                    builder: (BuildContext context, ReplaceFileState state) {
                      if (state is ReplaceFileLoadingState) {
                        return const Loader();
                      }
                      return ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<ReplaceFileCubit>(context)
                              .uploadFiles(
                            context: context,
                            fileKey: widget.Key,
                          );
                        },
                        child: const Text('replace'),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
