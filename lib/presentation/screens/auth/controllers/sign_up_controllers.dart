import 'package:flutter/material.dart';

class SignUpControllers {
  static TextEditingController firstNameTextController =
      TextEditingController();
  static TextEditingController lastNameTextController = TextEditingController();
  static TextEditingController accountNameTextController =
      TextEditingController();
  static TextEditingController emailTextController = TextEditingController();
  static TextEditingController passwordTextController = TextEditingController();
  static TextEditingController confirmPasswordTextController =
      TextEditingController();
  static TextEditingController fakeFieldController = TextEditingController();
  static final signUpFormKey = GlobalKey<FormState>();
  static String message = "";

  static void disposeControllers() {
    firstNameTextController.dispose();
    lastNameTextController.dispose();
    accountNameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    fakeFieldController.dispose();
  }

  static void initControllers() {
    firstNameTextController = TextEditingController();
    lastNameTextController = TextEditingController();
    accountNameTextController = TextEditingController();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
    fakeFieldController = TextEditingController();
    emailTextController = TextEditingController();
  }

  static void clearControllers() {
    firstNameTextController.clear();
    lastNameTextController.clear();
    accountNameTextController.clear();
    emailTextController.clear();
    passwordTextController.clear();
    confirmPasswordTextController.clear();
    fakeFieldController.clear();
  }

  static String? validateFirstName() {
    if (firstNameTextController.text.trim().length < 2) {
      if (message.isEmpty) message = "Correct the first name field";
      return "First name should be at least 2 letters";
    }
    message = "";

    return null;
  }

  static String? validateLastName() {
    if (lastNameTextController.text.trim().length < 2) {
      if (message.isEmpty) message = "Correct the last name field";

      return "First name should be at least 2 letters";
    }
    message = "";

    return null;
  }

  static String? validateAccountName() {
    if (accountNameTextController.text.trim().length < 6) {
      if (message.isEmpty) message = "Correct the account name field";

      return "Account name should be at least 6 letters";
    }
    message = "";

    return null;
  }

  static String? validateEmail() {
    if (emailTextController.text.trim().isEmpty) {
      if (message.isEmpty) message = "Correct the email field";

      return "Email cannot be empty";
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(emailTextController.text.trim())) {
      if (message.isEmpty) message = "Correct the email field";

      return "Invalid email";
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

  static String? validateConfirmPassword() {
    if (passwordTextController.text.trim().length < 8 ||
        passwordTextController.text.trim().length > 250) {
      if (message.isEmpty) message = "Correct the password confirmation field";

      return "Password should be between 8 and 255 characters";
    } else if (passwordTextController.text.trim() !=
        confirmPasswordTextController.text.trim()) {
      if (message.isEmpty) message = "Correct the password confirmation field";

      return "Passwords doesn't match";
    }
    message = "";

    return null;
  }
}
