import 'package:flutter/material.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, this.strokeWidth = 1, this.radius = 50});
  final double strokeWidth;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius,
      height: radius,
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
