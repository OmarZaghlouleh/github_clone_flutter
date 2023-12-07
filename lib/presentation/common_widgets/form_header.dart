import 'package:flutter/material.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';

class FormHeader extends StatelessWidget {
  const FormHeader(
      {super.key,
      required this.title,
      this.fittedBox = false,
      this.focused,
      this.fontSize,
      this.color});

  final String title;
  final bool? focused;
  final double? fontSize;
  final Color? color;
  final bool? fittedBox;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: fittedBox != true
          ? Text(
              "~ $title",
              style: AppTextStyle.getMediumBoldStyle(
                      color: color ?? AppColors.secondaryColor,
                      fontSize: fontSize ?? 20)
                  .copyWith(),
            )
          : FittedBox(
              child: Text(
                "~ $title",
                style: AppTextStyle.getMediumBoldStyle(
                        color: color ?? AppColors.primaryColor,
                        fontSize: fontSize ?? 20)
                    .copyWith(),
              ),
            ),
    );
  }
}
