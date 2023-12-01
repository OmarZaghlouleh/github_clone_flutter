import 'package:flutter/material.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';

InputDecoration inputDecorationTextFormField(
    String labelTextVal, BuildContext context) {
  return InputDecoration(
    // hintText: labelTextVal,
    suffix: const FittedBox(
      alignment: Alignment.center,
      fit: BoxFit.fitHeight,
      child: Icon(
        null,
        size: 30,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.secondaryColor, width: 1.5),
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.thirdColor, width: 1.5),
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.5),
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    //labelText: labelTextVal,
    label: Semantics(
      container: true,
      textField: true,
      label: labelTextVal,
      child: Text(
        labelTextVal,
        semanticsLabel: labelTextVal,
      ),
    ),
    labelStyle: const TextStyle(
        color: AppColors.primaryColor,
        fontSize: 15,
        fontWeight: FontWeight.bold),
  );
}
