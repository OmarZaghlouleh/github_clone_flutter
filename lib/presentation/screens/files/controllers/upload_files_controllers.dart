import 'package:flutter/material.dart';

class UploadFilesControllers {

  static final TextEditingController descriptionController = TextEditingController();
  static final TextEditingController commitController = TextEditingController();

  static void disposeControllers() {
    descriptionController.dispose();
    commitController.dispose();
  }

  static void clearControllers() {
    descriptionController.clear();
    commitController.clear();
  }

}
