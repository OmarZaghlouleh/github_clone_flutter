import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_clone_flutter/core/utils/extensions/space.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';

Size getMediaQueryInstance(BuildContext context) => MediaQuery.of(context).size;

void showSnackBar(
        {required String title,
        required BuildContext context,
        bool error = false}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        width: 500,
        elevation: 50,
        backgroundColor: AppColors.thirdColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              color: error ? AppColors.errorColor : AppColors.primaryColor,
              width: 2),
        ),
        content: SizedBox(
          child: Row(
            children: [
              if (error)
                const Icon(
                  Icons.error_outline_rounded,
                  color: AppColors.errorColor,
                ),
              if (error) 10.space(),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.snackbarTextStyle(),
                ),
              )
            ],
          ),
        ),
      ),
    );

void dprint(dynamic message) {
  if (kDebugMode) print(message); //TODO: remove it when upload the last release
}

void dlog(dynamic message) {
  if (kDebugMode) {
    log(message.toString()); //TODO: remove it  when upload the last release
  }
}
