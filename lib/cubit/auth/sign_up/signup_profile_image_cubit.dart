import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SignupProfileImageCubit extends Cubit<MemoryImage?> {
  SignupProfileImageCubit() : super(null);

  MemoryImage? fileImage;
  String fileName = "";

  void reset() {
    fileImage = null;
    fileName = "";
    emit(fileImage);
  }

  Future<void> pickProfileImage() async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
      // readSequential: true,
    );
    if (filePickerResult == null ||
        filePickerResult.files.single.bytes == null ||
        filePickerResult.files.length > 1 ||
        filePickerResult.files.isEmpty) {
      emit(fileImage);
    } else {
      fileName = filePickerResult.files.single.name;
      fileImage = MemoryImage(filePickerResult.files.single.bytes!);
      emit(fileImage);
    }
  }
}
