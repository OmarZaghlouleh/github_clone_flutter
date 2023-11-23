import 'package:flutter/material.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/border_radius.dart';

ThemeData appTheme() => ThemeData(
      fontFamily: 'SourceCodePro',
      primaryColor: AppColors.primaryColor,
      scrollbarTheme: ScrollbarThemeData(
        thickness: MaterialStateProperty.all(6),
        thumbColor: MaterialStateProperty.all(AppColors.primaryColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(BorderRadiusSizes.buttonBorderRadius),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            AppColors.primaryColor,
          ),
        ),
      ),
    );
