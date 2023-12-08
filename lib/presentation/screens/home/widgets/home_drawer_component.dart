import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/app_router.dart';
import 'package:github_clone_flutter/core/utils/extensions/space.dart';
import 'package:github_clone_flutter/cubit/group/all_groups_cubit.dart';
import 'package:github_clone_flutter/presentation/screens/files/all_files_screen.dart';
import 'package:github_clone_flutter/presentation/screens/group/create_group_screen.dart';
import 'package:github_clone_flutter/presentation/screens/group/update_group_screen.dart';
import 'package:github_clone_flutter/presentation/screens/files/files_list_screen.dart';
import 'package:github_clone_flutter/presentation/screens/groups/all_groups_screen.dart';
import 'package:github_clone_flutter/presentation/screens/reports/reports_screen.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../data/data_resource/local_resource/shared_preferences.dart';
import '../../../common_widgets/divider.dart';
import '../../auth/auth_screen.dart';
import '../../auth/controllers/sign_in_controllers.dart';
import '../../auth/controllers/sign_up_controllers.dart';
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
                      ListTile(
                        onTap: () async {
                          AppRouter.navigateTo(
                              context: context,
                              destination: const CreateGroupScreen());
                        },
                        title: Text(
                          'Create Group',
                          style: AppTextStyle.headerTextStyle(),
                        ),
                        leading: const Icon(
                          Icons.groups,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      ListTile(
                        onTap: () async {
                          AppRouter.navigateTo(
                              context: context,
                              destination: const UpdateGroupScreen());
                        },
                        title: Text(
                          'Update Group',
                          style: AppTextStyle.headerTextStyle(),
                        ),
                        leading: const Icon(
                          Icons.update_outlined,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      ListTile(
                        onTap: () async {
                          AppRouter.navigateTo(
                              context: context,
                              destination: const FilesListScreen(
                                groupKey: "",
                              ));
                        },
                        title: Text(
                          "My files",
                          style: AppTextStyle.headerTextStyle(),
                        ),
                        leading: const Icon(
                          Icons.file_copy_sharp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      if (LocalResource.getIfAdmin())
                        ExpansionTile(
                          leading: const Icon(
                            Icons.admin_panel_settings_rounded,
                            color: AppColors.primaryColor,
                          ),
                          title: Text(
                            'Dashboard',
                            style: AppTextStyle.headerTextStyle(),
                          ),
                          children: [
                            ListTile(
                              onTap: () async {
                                AppRouter.navigateTo(
                                    context: context,
                                    destination: ReportsScreen(
                                      keyString: "",
                                    ));
                              },
                              title: Text(
                                "Reports",
                                style: AppTextStyle.headerTextStyle(),
                              ),
                              leading: const Icon(
                                Icons.file_copy_rounded,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            ListTile(
                              onTap: () async {
                                AppRouter.navigateTo(
                                    context: context,
                                    destination: AllGroupsScreen());
                              },
                              title: Text(
                                "All Groups",
                                style: AppTextStyle.headerTextStyle(),
                              ),
                              leading: const Icon(
                                Icons.folder_copy_rounded,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            ListTile(
                              onTap: () async {
                                AppRouter.navigateTo(
                                    context: context,
                                    destination: AllFilesScreen());
                              },
                              title: Text(
                                "All Files",
                                style: AppTextStyle.headerTextStyle(),
                              ),
                              leading: const Icon(
                                Icons.file_present_rounded,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
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
                              // We should add these 2 functions because we disposed controllers after sign in/up
                              SignInControllers.initControllers();
                              SignUpControllers.initControllers();
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
                              // We should add these 2 functions because we disposed controllers after sign in/up
                              SignInControllers.initControllers();
                              SignUpControllers.initControllers();
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
