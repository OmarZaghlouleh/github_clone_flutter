import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SignupProfileImageCubit extends Cubit<FileImage?> {
  SignupProfileImageCubit() : super(null);

  FileImage? fileImage;

  Future<void> pickProfileImage() async {
    FilePickerResult? filePickerResult = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);
    if (filePickerResult == null ||
        filePickerResult.files.length > 1 ||
        filePickerResult.files.isEmpty) {
      emit(fileImage);
    } else {
      fileImage = FileImage(
        File(filePickerResult.files.first.path!),
      );
      emit(fileImage);
    }
  }
}
