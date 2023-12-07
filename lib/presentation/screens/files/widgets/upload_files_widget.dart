import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/cubit/add_files_to_group/add_files_to_group_cubit.dart';
import 'package:github_clone_flutter/domain/models/params/add_files_to_group_params.dart';
import 'package:github_clone_flutter/presentation/common_widgets/custom_text_form_field.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../data/data_resource/local_resource/shared_preferences.dart';

class UploadFileWidget extends StatefulWidget {
  final String groupKey;

  const UploadFileWidget({super.key, required this.groupKey});

  @override
  _UploadFileWidgetState createState() => _UploadFileWidgetState();
}

class _UploadFileWidgetState extends State<UploadFileWidget> {
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
      FormData formData =  FormData.fromMap({
        "file": MultipartFile.fromBytes(
          result!.files.single.bytes!,
          filename: result!.files.single.name,
        ),
      });

    BlocProvider.of<AddFilesToGroupCubit>(context).addFilesToGroupParams(
          addFilesToGroupParams: AddFilesToGroupParams(
              commit: _commitController.text,
              filesArray: [formData],
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
      child: Center(
        child: Container(
          width: 0.5.mqWidth(context),
          height: 0.5.mqHeight(context),
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  label: 'add commit',
                  textInputType: TextInputType.text,
                  controller: _commitController,
                  maxLines: null,
                  minLines: 2,
                ),
                SizedBox(height: 0.01.mqHeight(context)),
                CustomTextFormField(
                    label: 'add description',
                    textInputType: TextInputType.text,
                    controller: _descriptionController),
                SizedBox(height: 0.01.mqHeight(context)),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                            _file?.files.first.name ?? 'No file selected')),
                    ElevatedButton(
                      onPressed: _pickFile,
                      child: const Text('Pick a file'),
                    ),
                  ],
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
        ),
      ),
    );
  }
}
