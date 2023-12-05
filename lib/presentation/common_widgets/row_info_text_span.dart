import 'package:flutter/material.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';

import '../style/app_text_style.dart';
import 'empty_widget.dart';

class RowInfoTextSpan extends StatelessWidget {
  RowInfoTextSpan({
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

  @override
  Widget build(BuildContext context) {
    if (label2.isEmpty) return const EmptyWidget();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$label1: ",
                  style: AppTextStyle.getSmallBoldStyle(
                      color: label1Color ?? AppColors.secondaryColor),
                ),
                TextSpan(
                  text: isNearly ? "~$label2" : label2,
                  style: AppTextStyle.getSmallBoldStyle(
                      color: label2Color ?? AppColors.thirdColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
