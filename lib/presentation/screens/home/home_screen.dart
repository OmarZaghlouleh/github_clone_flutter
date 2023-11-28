import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_clone_flutter/presentation/common_widgets/divider.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';

import '../../style/app_text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.secondaryColor,
          title: Text(
            "Welcome: " + "name",
            style: AppTextStyle.headerTextStyle(),
          )),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: AppColors.lightGrey,
              radius: 65,
              // backgroundImage: ,
              // // onBackgroundImageError: value
              //     ? null
              //     : (exception, stackTrace) =>
              //         Provider.of<BeneficiaryProvider>(context, listen: false)
              //             .setIsImageFail(state: true),
              backgroundImage: //!value
                  // ?
                  CachedNetworkImageProvider(
                      "https://www.iconpacks.net/icons/2/free-file-icon-1453-thumb.png")
              // : null
              ,
              child:
                  //  value
                  //     ?
                  Icon(
                CupertinoIcons.person_alt,
                color: AppColors.darkGrey,
                size: 40,
              )
              // : null
              ,
            ),
          ),
          const CustomDivider(),
          Text(
            "namef+l",
            style: AppTextStyle.headerTextStyle(),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "email@.com",
              style: AppTextStyle.descriptionStyle(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "role type",
                style: AppTextStyle.headerTextStyle(),
              ),
              const Icon(
                (true) ? Icons.admin_panel_settings : Icons.person_rounded,
                color: AppColors.secondaryColor,
              ),
            ],
          ),
          Text(
            //  "created_at": "2023-11-09 17:53",
            "groups_count commits_count commits_this_year",
            style: AppTextStyle.headerTextStyle(),
          ),
        ]),
      ),
    );
  }
}
