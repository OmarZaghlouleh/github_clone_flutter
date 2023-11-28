import 'package:flutter/material.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_font_size.dart';

class AppTextStyle {
  static TextStyle headerTextStyle() => const TextStyle(
        color: AppColors.primaryColor,
        fontSize: AppFontSize.headerFontSize,
        fontWeight: FontWeight.w700,
      );
  static TextStyle descriptionStyle() => const TextStyle(
        color: AppColors.secondaryColor,
        fontSize: AppFontSize.descriptionFontSize,
        fontWeight: FontWeight.w500,
      );
  static TextStyle elevatedButtonTextStyle() => const TextStyle(
        color: AppColors.thirdColor,
        fontSize: AppFontSize.elevatedButtonTextFontSize,
        fontWeight: FontWeight.w400,
      );
  static TextStyle snackbarTextStyle() => const TextStyle(
        color: AppColors.primaryColor,
        fontSize: AppFontSize.snackbarTextFontSize,
        fontWeight: FontWeight.w500,
      );
  static TextStyle authTextButtonStyle() => const TextStyle(
        color: AppColors.primaryColor,
        fontSize: AppFontSize.authTextButtonFontSize,
        fontWeight: FontWeight.w500,
      );
  static TextStyle creatorsTextStyle() => const TextStyle(
        color: AppColors.primaryColor,
        fontSize: AppFontSize.creatorsTextFontSize,
        fontWeight: FontWeight.w600,
      );
}
