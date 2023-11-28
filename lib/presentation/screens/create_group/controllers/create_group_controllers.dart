import 'package:flutter/cupertino.dart';

class CreateGroupControllers {
  static final nameGroupTextController = TextEditingController();
  static final descriptionGroupTextController = TextEditingController();
  static final createGroupFormKey = GlobalKey<FormState>();
  static final RegExp nameRegExp = RegExp('[a-zA-Z]');

  static void disposeControllers() {
    nameGroupTextController.dispose();
    descriptionGroupTextController.dispose();
  }

  static void clearControllers() {
    nameGroupTextController.clear();
    descriptionGroupTextController.clear();
  }

  static String? validateGroupName(String value) {
    if (value.isEmpty) {
      return 'Enter Your Name';
    } else {
      if (nameRegExp.hasMatch(value)) {
        return null;
      } else {
        return 'Enter a Valid Name';
      }
    }
  }

  static String? validateDescriptionName() {

  }
}
