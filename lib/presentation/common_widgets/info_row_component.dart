import 'package:flutter/material.dart';
import 'package:github_clone_flutter/core/utils/extensions/space.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';

import '../style/app_text_style.dart';
import 'empty_widget.dart';

class InfoRow extends StatelessWidget {
  InfoRow({
    super.key,
    required this.label1,
    required this.label2,
    this.isNearly = false,
    this.label1Color,
    this.label2Color,
  });

  final String label1;
  final String label2;
  bool isNearly = false;
  Color? label1Color;
  Color? label2Color;
  String? label2Semantic;
  String? label1Semantic;
  @override
  Widget build(BuildContext context) {
    if (label2.isEmpty) return const EmptyWidget();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$label1:",
            style: AppTextStyle.getSmallBoldStyle(
                color: label1Color ?? AppColors.secondaryColor),
            textAlign: TextAlign.start,
          ),
          10.space(),
          Expanded(
            child: Text(
              isNearly ? "~$label2" : label2,
              style: AppTextStyle.getSmallBoldStyle(
                  color: label2Color ?? AppColors.primaryColor),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
