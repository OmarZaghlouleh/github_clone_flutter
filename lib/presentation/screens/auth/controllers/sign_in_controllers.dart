import 'package:flutter/material.dart';

class SignInControllers {
  static final accountNameTextController = TextEditingController();
  static final passwordTextController = TextEditingController();
  static final fakeFieldController = TextEditingController();
  static final signInFormKey = GlobalKey<FormState>();
  static String message = "";

  static void disposeControllers() {
    accountNameTextController.dispose();
    passwordTextController.dispose();
    fakeFieldController.dispose();
  }

  static void clearControllers() {
    accountNameTextController.clear();
    passwordTextController.clear();
    fakeFieldController.clear();
  }

  static String? validateAccountName() {
    if (accountNameTextController.text.trim().length < 6) {
      if (message.isEmpty) message = "Correct the account name field";

      return "Account name should be at least 6 letters";
    }
    message = "";

    return null;
  }

  static String? validatePassword() {
    if (passwordTextController.text.trim().length < 8 ||
        passwordTextController.text.trim().length > 250) {
      if (message.isEmpty) message = "Correct the password field";

      return "Password should be between 8 and 255 characters";
    }
    message = "";
    return null;
  }
}
