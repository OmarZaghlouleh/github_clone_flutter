import 'package:flutter/material.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      endIndent: 0.3.mqWdith(context),
      indent: 0.3.mqWdith(context),
      color: AppColors.secondaryColor,
    );
  }
}
