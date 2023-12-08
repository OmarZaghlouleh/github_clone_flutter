import 'package:flutter/material.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';

class CardRow extends StatelessWidget {
  const CardRow(
      {super.key,
      required this.title,
      required this.description,
      this.textStyle});

  final String title;
  final String description;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    if (description.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: textStyle ??
                AppTextStyle.getMediumBoldStyle(color: AppColors.thirdColor),
          ),
          Expanded(
            child: Text(
              description,
              style: textStyle ??
                  AppTextStyle.getMediumBoldStyle(color: AppColors.thirdColor),
            ),
          ),
        ],
      ),
    );
  }
}
