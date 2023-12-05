import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:github_clone_flutter/presentation/screens/profile/profile_screen.dart';

import '../../../../core/utils/app_router.dart';
import '../../../../data/data_resource/remote_resource/links.dart';
import '../../../../domain/models/profile_model.dart';
import '../../../style/app_colors.dart';
import '../../../style/app_text_style.dart';

Widget contributerCard(BuildContext context, ProfileModel profileModel) {
  bool imageError = false;
  return InkWell(
    onTap: () {
      AppRouter.navigateTo(
          context: context,
          destination: ProfileScreen(profileId: profileModel.id));
    },
    child: Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.thirdColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
          // boxShadow: [
          //   BoxShadow(
          //     color: AppColors.shadowColor,
          //     blurRadius: 30,
          //     offset: const Offset(10, 15),
          //   )
          // ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatar(
                  backgroundColor: AppColors.thirdColor.withOpacity(0.1),
                  radius: 10,
                  backgroundImage: CachedNetworkImageProvider(
                    Links.baseUrl + profileModel.img,
                    // "https://www.iconpacks.net/icons/2/free-file-icon-1453-thumb.png",
                  ),
                  onBackgroundImageError: (exception, stackTrace) {
                    // setState(() {
                    //   imageError = true;
                    // });
                  },
                  child: null,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      "${profileModel.firstName} ${profileModel.lastName}",
                      style: AppTextStyle.getSmallBoldStyle(
                          color: AppColors.thirdColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      profileModel.accountName,
                      style: AppTextStyle.getSmallBoldStyle(
                          color: AppColors.secondaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
