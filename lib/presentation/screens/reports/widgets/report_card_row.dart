import 'package:flutter/material.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';

class ReportRowCard extends StatelessWidget {
  const ReportRowCard(
      {super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title: ",
          style: AppTextStyle.getMediumBoldStyle(color: AppColors.thirdColor),
        ),
        Expanded(
          child: Text(
            description,
            style: AppTextStyle.getMediumBoldStyle(color: AppColors.thirdColor),
          ),
        ),
      ],
    );
  }
}
