import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/cubit/add_files_to_group/add_files_to_group_cubit.dart';
import 'package:github_clone_flutter/domain/models/params/add_files_to_group_params.dart';
import 'package:github_clone_flutter/presentation/common_widgets/custom_text_form_field.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';


class UploadFileWidget extends StatefulWidget {
  final String groupKey;

  const UploadFileWidget({super.key, required this.groupKey});

  @override
  UploadFileWidgetState createState() => UploadFileWidgetState();
}

class UploadFileWidgetState extends State<UploadFileWidget> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _commitController = TextEditingController();
  FilePickerResult? _file;
  FilePickerResult? result;

  void _pickFile() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      withData: true,
    );

    if (result != null) {
      setState(() {
        _file = result;
      });
    }
  }

  Future<void> uploadFile() async {
    if (result != null) {
      BlocProvider.of<AddFilesToGroupCubit>(context).addFilesToGroupParams(
          addFilesToGroupParams: AddFilesToGroupParams(
              commit: _commitController.text,
              filesArray: result!.files
                  .map((e) =>
                      MultipartFile.fromBytes(e.bytes!, filename: "-${e.name}"))
                  .toList(),
              filesDesc: [_descriptionController.text],
              groupKey: widget.groupKey));
    } else {
      // Throw an exception
      throw Exception('No file selected');
    }
  }

  @override
  Widget build(BuildContext context) {
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
              controller: _commitController,
              maxLines: null,
              minLines: 2,
            ),
            SizedBox(height: 0.05.mqHeight(context)),
            Container(
              height: 0.4.mqHeight(context),
              width: 0.53.mqWidth(context),
              padding:const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.darkGrey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10)
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextFormField(
                        label: 'add description',
                        textInputType: TextInputType.text,
                        controller: _descriptionController),
                    SizedBox(height: 0.01.mqHeight(context)),
                    Row(
                      children: [
                        SizedBox(width: 0.01.mqWidth(context)),
                        Expanded(
                          flex: 2,
                            child: Text(_file?.files.first.name ??
                                'No file selected')),
                        ElevatedButton(
                          onPressed: _pickFile,
                          child: const Text('Pick a file'),
                        ),
                      ],
                    ),


                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            // a button to upload the file
            ElevatedButton(
              onPressed: uploadFile,
              child: const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
