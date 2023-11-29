import 'package:flutter/material.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, this.start = 50, this.end = 50});
  final double start;
  final double end;

  @override
  Widget build(BuildContext context) {
    return Divider(
      endIndent: end,
      indent: start,
      color: AppColors.secondaryColor,
    );
  }
}
