import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/cubit/profile/profile_cubit.dart';
import 'package:github_clone_flutter/presentation/common_widgets/divider.dart';
import 'package:github_clone_flutter/presentation/common_widgets/empty_widget.dart';
import 'package:github_clone_flutter/presentation/screens/home/widgets/home_drawer_component.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/global.dart';
import '../../../core/utils/strings_manager.dart';
import '../../../data/data_resource/remote_resource/links.dart';
import '../../common_widgets/info_row_component.dart';
import '../../common_widgets/loader.dart';
import '../../style/app_text_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.profileId});
  final int profileId;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() => scaffoldkey.currentState?.openDrawer());
    BlocProvider.of<ProfileCubit>(context).getProfile(context: context);
  }

  bool imageError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: AppColors.thirdColor.withOpacity(0),
      drawer: (1.mqWdith(context) < bigScreen) ? const HomeDrawer() : null,
      appBar: AppBar(
          // backgroundColor: AppColors.secondaryColor,
          // title: Text(
          //   "Welcome!",
          //   style: AppTextStyle.headerTextStyle(),
          // ),
          ),
      body: BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: Loader());
        }
        if (state is ProfileLoaded) {
          return SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: AppColors.lightGrey,
                  radius: 100,
                  backgroundImage:
                      //  !(state).profile.img
                      //   ?
                      const CachedNetworkImageProvider(
                    // Links.baseUrl + (state).profile.img
                    "https://www.iconpacks.net/icons/2/free-file-icon-1453-thumb.png",
                  )
                  // : null
                  ,
                  onBackgroundImageError: (exception, stackTrace) {
                    setState(() {
                      imageError = true;
                    });
                  },
                  child: imageError
                      ? Icon(
                          CupertinoIcons.person_alt,
                          color: AppColors.darkGrey,
                          size: 50,
                        )
                      : null,
                ),
                // CircleAvatar(
                //   backgroundColor: ColorManager.lightGrey,
                //   radius: 65,
                //   onBackgroundImageError: value
                //       ? null
                //       : (exception, stackTrace) =>
                //           Provider.of<BeneficiaryProvider>(context,
                //                   listen: false)
                //               .setIsImageFail(state: true),
                //   backgroundImage: !value
                //       ? CachedNetworkImageProvider(
                //           beneficiaryEntity.profileImage)
                //       : null,
                //   child: value
                //       ? Icon(
                //           Icons.person,
                //           color: ColorManager.grey,
                //           size: 40,
                //         )
                //       : null,
                // ),
              ),
              CustomDivider(
                start: 0.3.mqWdith(context),
                end: 0.3.mqWdith(context),
              ),
              Text(
                "${(state).profile.firstName} ${(state).profile.lastName}",
                style: AppTextStyle.headerTextStyle(),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  (state).profile.email,
                  style: AppTextStyle.descriptionStyle(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (state).profile.roleName,
                    style: AppTextStyle.headerTextStyle(),
                  ),
                  Icon(
                    ((state).profile.role == 1)
                        ? Icons.admin_panel_settings
                        : Icons.person_rounded,
                    color: AppColors.secondaryColor,
                  ),
                ],
              ),
              InfoRow(
                label1: "Groups count",
                label2: (state).profile.groupsCount.toString(),
                // label2Color: AppColors.secondaryColor,
              ),
              InfoRow(
                label1: "Commits count",
                label2: (state).profile.commitsCount.toString(),
                // label2Color: AppColors.secondaryColor,
              ),
              InfoRow(
                label1: "Commits this year",
                label2: (state).profile.commitsThisYear.toString(),
                // label2Color: AppColors.secondaryColor,
              ),
              InfoRow(
                label1: "Created at",
                label2: (state).profile.createdAt,
                // label2Color: AppColors.secondaryColor,
              ),
            ]),
          );
        }
        if (state is ProfileError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  (state).profileErrorMessage,
                  style: AppTextStyle.getMediumBoldStyle(
                      color: AppColors.secondaryColor),
                ),
                TextButton.icon(
                  label: Text(
                    StringManager.refresh,
                    style: AppTextStyle.getMediumBoldStyle(
                        color: AppColors.secondaryColor),
                  ),
                  icon: const Icon(Icons.refresh_outlined),
                  onPressed: () {
                    setState(() {
                      imageError = false;
                    });
                    BlocProvider.of<ProfileCubit>(context)
                        .getProfile(context: context);
                  },
                ),
              ],
            ),
          );
        }
        return const EmptyWidget();
      }),
    );
  }
}
