import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:github_clone_flutter/core/utils/app_router.dart';
import 'package:github_clone_flutter/core/utils/constants.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/core/utils/extensions/space.dart';
import 'package:github_clone_flutter/data/data_resource/local_resource/shared_preferences.dart';
import 'package:github_clone_flutter/presentation/common_widgets/loader.dart';
import 'package:github_clone_flutter/presentation/screens/auth/auth_screen.dart';
import 'package:github_clone_flutter/presentation/screens/home/home_screen.dart';
import 'package:github_clone_flutter/presentation/style/app_assets.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';
import 'package:github_clone_flutter/presentation/style/device_sizes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigate();
    super.initState();
  }

  Future<void> navigate() async {
    await Future.delayed(Durations.long2).then((value) {
      if (LocalResource.getIfUserRegistered()) {
        AppRouter.navigateReplacementTo(
            context: context, destination: const HomeScreen());
      } else {
        AppRouter.navigateReplacementTo(
            context: context, destination: const AuthScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeIn(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Loader(
                strokeWidth: 3,
                radius: 0.28.mqHeight(context),
              ),
              Image(
                width: 0.35.mqHeight(context),
                height: 0.35.mqHeight(context),
                image: const AssetImage(
                  AppAssets.logo,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
