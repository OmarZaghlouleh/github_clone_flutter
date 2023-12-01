import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_clone_flutter/core/utils/extensions/space.dart';
import 'package:github_clone_flutter/presentation/screens/auth/auth_screen.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';

import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../data/data_resource/local_resource/shared_preferences.dart';
import '../../../common_widgets/divider.dart';
import '../../groups/my_groups_screen.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        // clipBehavior: Clip.hardEdge,
        // shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
        // backgroundColor: Colors.yellow,
        // shadowColor: Colors.green,
        // surfaceTintColor: Colors.purple,
        // elevation: 0,
        child: Center(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Welcome
              30.space(),
              // Selector<HomeProvider, HomeDataEntity?>(
              //   selector: (p0, p1) => p1.getHomeData,
              //   builder: (context, value, child) => value == null
              //       ? const EmptyWidget()
              //       : Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //             "${StringManager.welcome} ${value.userName}",
              //             style: getSmallBoldStyle(
              //                 color:  AppColors.primaryColor, fontSize: 20),
              //           ),
              //         ),
              // ),
              15.space(),
              const CustomDivider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () async {
                          AppRouter.navigateTo(
                              context: context,
                              destination: const MyGroupsScreen());
                        },
                        title: Text(
                          "My groups",
                          style: AppTextStyle.headerTextStyle(),
                        ),
                        leading: const Icon(
                          Icons.people_rounded,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const CustomDivider(),
                      ExpansionTile(
                        title: Text(
                          StringManager.logout,
                          style: AppTextStyle.getSmallBoldStyle(
                            color: AppColors.errorColor,
                          ),
                        ),
                        leading: const Icon(
                          Icons.logout,
                          color: AppColors.errorColor,
                        ),
                        children: [
                          ListTile(
                            onTap: () async {
                              //TODO: add API request
                              LocalResource.deleteUserData();
                              AppRouter.navigateReplacementTo(
                                  context: context,
                                  destination: const AuthScreen());
                            },
                            title: Text(
                              StringManager.logoutFromThisDevice,
                              style: AppTextStyle.getSmallBoldStyle(
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            leading: const Icon(
                              Icons.stop_screen_share_outlined,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          ListTile(
                            onTap: () async {
                              //TODO: add API request
                              LocalResource.deleteUserData();
                              AppRouter.navigateReplacementTo(
                                  context: context,
                                  destination: const AuthScreen());
                            },
                            title: Text(
                              StringManager.logoutFromAllDevices,
                              style: AppTextStyle.getSmallBoldStyle(
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            leading: const Icon(
                              Icons.devices_other_outlined,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      50.space(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
