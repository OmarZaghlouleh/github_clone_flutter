import 'package:flutter/material.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';

ThemeData appTheme() => ThemeData(
      fontFamily: 'SourceCodePro',
      primaryColor: AppColors.primaryColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            AppColors.primaryColor,
          ),
        ),
      ),
    );
