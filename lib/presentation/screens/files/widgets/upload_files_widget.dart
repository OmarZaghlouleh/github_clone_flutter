import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/cubit/add_files_to_group/add_files_to_group_cubit.dart';
import 'package:github_clone_flutter/presentation/common_widgets/custom_text_form_field.dart';
import 'package:github_clone_flutter/presentation/screens/files/controllers/upload_files_controllers.dart';
import 'package:github_clone_flutter/presentation/screens/files/widgets/upload_file_card_widget.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';

class UploadFileWidget extends StatefulWidget {
  final String groupKey;

  const UploadFileWidget({super.key, required this.groupKey});

  @override
  UploadFileWidgetState createState() => UploadFileWidgetState();
}

class UploadFileWidgetState extends State<UploadFileWidget> {
  @override
  Widget build(BuildContext context) {
    final AddFilesToGroupCubit addFilesToGroupCubit =
        BlocProvider.of<AddFilesToGroupCubit>(context);
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child:
                        BlocBuilder<AddFilesToGroupCubit, AddFilesToGroupState>(
                      builder: (context, state) {
                        return ListView.builder(
                          itemCount: addFilesToGroupCubit.uploadFileCardWidgetList.length,
                          itemBuilder: (context, index) =>
                              UploadFileCardWidget(
                                index: addFilesToGroupCubit.uploadFileCardWidgetList[index].index,
                                description: addFilesToGroupCubit.uploadFileCardWidgetList[index].description,
                                file: addFilesToGroupCubit.uploadFileCardWidgetList[index].file,
                              ),
                        );
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      int newIndexFile =
                          addFilesToGroupCubit.uploadFileCardWidgetList.length;
                      addFilesToGroupCubit.result.add(null);
                      addFilesToGroupCubit.uploadFileCardWidgetList
                          .add(UploadFileCardWidget(
                        index: newIndexFile,
                        description: TextEditingController(),
                        file: null,
                      ));
                      addFilesToGroupCubit.emit(AddFilesToGroupStateInitial());
                    },
                    icon: const Icon(Icons.add),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),
            // a button to upload the file
            ElevatedButton(
              onPressed: () {
                addFilesToGroupCubit.uploadFiles(
                  context: context,
                  groupKey: widget.groupKey,
                );

              },
              child: const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
