import 'package:flutter/material.dart';

class SignInControllers {
  static TextEditingController accountNameTextController =
      TextEditingController();
  static TextEditingController passwordTextController = TextEditingController();
  static TextEditingController fakeFieldController = TextEditingController();
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

  static void initControllers() {
    accountNameTextController = TextEditingController();
    passwordTextController = TextEditingController();
    fakeFieldController = TextEditingController();
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
