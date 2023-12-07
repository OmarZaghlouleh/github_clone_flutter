import 'package:flutter/material.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';

import '../../core/utils/strings_manager.dart';

Future<bool> showConfirmDialog(
    {required BuildContext context, required String contentText}) async {
  bool status = false;
  await showDialog(
    context: context,
    builder: (BuildContext ctx) => AlertDialog(
      content: Text(
        contentText,
        style: AppTextStyle.getSmallBoldStyle(
          color: AppColors.darkGrey,
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            status = true;
          },
          child: Text(
            StringManager.yes,
            style: AppTextStyle.getSmallBoldStyle(
              color: AppColors.secondaryColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            status = false;
          },
          child: Text(
            StringManager.no,
            style: AppTextStyle.getSmallBoldStyle(
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      ],
    ),
  );
  return status;
}
