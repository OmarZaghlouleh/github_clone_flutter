import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';

import '../../../../cubit/add_files_to_group/add_files_to_group_cubit.dart';
import '../../../common_widgets/custom_text_form_field.dart';

class UploadFileCardWidget extends StatefulWidget {
  final TextEditingController? description;
  final int? index;
  FilePickerResult? file;

  UploadFileCardWidget({
    super.key,
    required this.description,
    required this.index,
    this.file,
  });

  @override
  State<UploadFileCardWidget> createState() => _UploadFileCardWidgetState();
}

class _UploadFileCardWidgetState extends State<UploadFileCardWidget> {
  @override
  Widget build(BuildContext context) {
    final AddFilesToGroupCubit addFilesToGroupCubit =
        BlocProvider.of<AddFilesToGroupCubit>(context);
    return Column(
      children: [
        CustomTextFormField(
          label: 'add description',
          textInputType: TextInputType.text,
          controller: widget.description!,
        ),
        SizedBox(height: 0.01.mqHeight(context)),
        Row(
          children: [
            SizedBox(width: 0.01.mqWidth(context)),
            Expanded(
              flex: 2,
              child: BlocBuilder<AddFilesToGroupCubit, AddFilesToGroupState>(
                builder: (context, state) {
                  if (state is AddFilesToGroupStatePickedFile &&
                      state.index == widget.index) {
                    return Text(state.result!.files.first.name);
                  } else if (addFilesToGroupCubit
                          .uploadFileCardWidgetList[widget.index!].file !=
                      null) {
                    return Text(addFilesToGroupCubit
                        .uploadFileCardWidgetList[widget.index!]
                        .file!
                        .files
                        .first
                        .name);
                  }
                  return const Text('No file selected');
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                addFilesToGroupCubit.pickFile(widget.index!);
              },
              child: const Text('Pick a file'),
            ),
          ],
        ),
      ],
    );
  }
}
