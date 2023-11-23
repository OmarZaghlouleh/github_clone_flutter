import 'package:flutter/material.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/core/utils/image_helper.dart';
import 'package:github_clone_flutter/presentation/screens/auth/widgets/sign_up_form.dart';
import 'package:github_clone_flutter/presentation/style/app_assets.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/border_radius.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Container(
          width: 0.95.mqWdith(context),
          height: 0.95.mqHeight(context),
          decoration: BoxDecoration(
            color: AppColors.thirdColor,
            borderRadius: BorderRadius.circular(
              BorderRadiusSizes.authContainerRadius,
            ),
          ),
          child: Row(
            children: [
              //SignUp Form
              const Expanded(
                child: SignUpForm(),
              ),
              //Background
              Expanded(
                flex: 2,
                child: const ImageWidget(
                  url: AppAssets.authImage,
                  color: AppColors.secondaryColor,
                ).buildAssetSvgImage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
