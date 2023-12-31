import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/app_router.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/core/utils/extensions/space.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/cubit/profile/profile_cubit.dart';
import 'package:github_clone_flutter/presentation/common_widgets/divider.dart';
import 'package:github_clone_flutter/presentation/common_widgets/empty_widget.dart';
import 'package:github_clone_flutter/presentation/screens/files/files_list_screen.dart';
import 'package:github_clone_flutter/presentation/screens/groups/my_groups_screen.dart';
import 'package:github_clone_flutter/presentation/screens/home/widgets/home_drawer_component.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/global.dart';
import '../../../core/utils/service_locator_di.dart';
import '../../../core/utils/strings_manager.dart';
import '../../../data/data_resource/remote_resource/links.dart';
import '../../../data/data_resource/remote_resource/repository/groups_repo.dart';
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
    if (widget.profileId == -1) {
      Timer.run(() => scaffoldkey.currentState?.openDrawer());
    }
    BlocProvider.of<ProfileCubit>(context)
        .getProfile(context: context, id: widget.profileId);
  }

  bool imageError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: AppColors.thirdColor.withOpacity(0),
      drawer: widget.profileId == -1
          ? (1.mqWidth(context) < bigScreen)
              ? const HomeDrawer()
              : null
          : null,
      // onDrawerChanged: (value) {
      //   dprint("ggggggggggggggggggggggggggggggggggggggg");
      //   dprint(value);
      //   if (widget.profileId == -1) {
      //     BlocProvider.of<ProfileCubit>(context)
      //         .getProfile(context: context, id: widget.profileId);
      //   }
      // },
      appBar: AppBar(),
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
                  backgroundImage: CachedNetworkImageProvider(
                    Links.baseUrlForImage + (state).profile.img,
                  ),
                  onBackgroundImageError: (exception, stackTrace) {
                    setState(() {
                      imageError = true;
                    });
                  },
                  child: imageError
                      ? const Icon(
                          CupertinoIcons.person_alt,
                          color: AppColors.primaryColor,
                          size: 50,
                        )
                      : null,
                ),
              ),
              CustomDivider(
                start: 0.25.mqWidth(context),
                end: 0.25.mqWidth(context),
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
              if (widget.profileId != -1)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            AppRouter.navigateTo(
                                context: context,
                                destination: MyGroupsScreen(
                                  userId: widget.profileId,
                                ));
                          },
                          child: Text(
                            "Groups",
                            style: AppTextStyle.getMediumBoldStyle(
                                color: AppColors.thirdColor),
                          )),
                    ),
                    // 10.space(),
                    // SizedBox(
                    //   width: 150,
                    //   height: 50,
                    //   child: ElevatedButton(
                    //       onPressed: () {
                    //         AppRouter.navigateTo(
                    //             context: context,
                    //             destination: FilesListScreen(
                    //               groupKey: "",
                    //               userId: widget.profileId,
                    //             ));
                    //       },
                    //       child: Text(
                    //         "Files",
                    //         style: AppTextStyle.getMediumBoldStyle(
                    //             color: AppColors.thirdColor),
                    //       )),
                    // )
                  ],
                )
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
                        .getProfile(context: context, id: widget.profileId);
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
