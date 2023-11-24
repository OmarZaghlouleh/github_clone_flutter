import 'package:flutter/material.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';

import '../../style/app_text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        backgroundColor: AppColors.secondaryColor,
title: Text("Welcome: " + "name",               
 style: AppTextStyle.headerTextStyle(),
)),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "namef+l",
                style: AppTextStyle.headerTextStyle(),
              ),
              const Icon(
                (true) ? Icons.admin_panel_settings : Icons.person_rounded,
                color: AppColors.secondaryColor,
              ),
            ],
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                "email@.com",
                style: AppTextStyle.descriptionStyle(),
              ),),
        ]),
      ),
    );
  }
}
