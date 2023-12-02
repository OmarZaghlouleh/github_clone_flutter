import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/app_router.dart';
import 'package:github_clone_flutter/core/utils/extensions/space.dart';
import 'package:github_clone_flutter/cubit/get_list_users/get_list_users_cubit.dart';
import 'package:github_clone_flutter/presentation/screens/group/create_group_screen.dart';
import 'package:github_clone_flutter/presentation/screens/group/update_group_screen.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';

import '../../../common_widgets/divider.dart';

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
                      //Beneficiaries list
                      ListTile(
                        onTap: () async {
                          // Navigator.pushNamed(
                          //     context, RoutesManager.beneficiariesListRoute);
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
                          AppRouter.navigateTo(context: context, destination:const CreateGroupScreen());
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
                          AppRouter.navigateTo(context: context, destination:const UpdateGroupScreen());
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
                      // //Donations list
                      // ListTile(
                      //   onTap: () async {
                      //     // Navigator.pushNamed(
                      //     //     context, RoutesManager.donationsListRoute);
                      //   },
                      //   title: Text(
                      //     "",
                      //     style: AppTextStyle.headerTextStyle(),
                      //   ),
                      //   leading: Icon(
                      //     CupertinoIcons.cube_box_fill,
                      //     color: AppColors.primaryColor,
                      //   ),
                      // ),

                      // const CustomDivider(),
                      //Language
                      /*       Selector<HomeProvider, Locale>(
                        selector: (p0, p1) => p1.getLanguage,
                        builder: (context, value, child) => ExpansionTile(
                          title: Text(
                            StringManager.language,
                            style: getSmallBoldStyle(
                              color:  AppColors.primaryColor,
                            ),
                          ),
                          leading: Icon(
                            Icons.language,
                            color:  AppColors.primaryColor,
                          ),
                          children: [
                            RadioListTile(
                                title: Text(
                                  StringManager.arabicLang,
                                  style: getSmallBoldStyle(
                                      color: ColorManager.secondaryCol),
                                ),
                                value: const Locale(arabic),
                                groupValue: value,
                                onChanged: (_) async {
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .toggleLanguage(
                                          locale: const Locale(arabic),
                                          context: context);
                                }),
                            RadioListTile(
                                title: Text(
                                  StringManager.englishLang,
                                  style: getSmallBoldStyle(
                                      color: ColorManager.secondaryCol),
                                ),
                                value: const Locale(english),
                                groupValue: value,
                                onChanged: (_) {
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .toggleLanguage(
                                          locale: const Locale(english),
                                          context: context);
                                })
                          ],
                        ),
                      ),
*/
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
