import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/app_router.dart';
import 'package:github_clone_flutter/core/utils/extensions/space.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/cubit/group/all_groups_cubit.dart';
import 'package:github_clone_flutter/cubit/group/group_contributers_cubit.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/links.dart';
import 'package:github_clone_flutter/presentation/common_widgets/custom_text_form_field.dart';
import 'package:github_clone_flutter/presentation/common_widgets/divider.dart';
import 'package:github_clone_flutter/presentation/common_widgets/loader.dart';
import 'package:github_clone_flutter/presentation/screens/files/files_list_screen.dart';
import 'package:github_clone_flutter/presentation/screens/groups/widgets/filters.dart';
import 'package:github_clone_flutter/presentation/common_widgets/card_row.dart';
import 'package:github_clone_flutter/presentation/screens/profile/profile_screen.dart';
import 'package:github_clone_flutter/presentation/screens/reports/reports_screen.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';

class GroupContributersScreen extends StatelessWidget {
  GroupContributersScreen(
      {super.key, required this.groupKey, required this.groupName});

  final String groupKey;
  final String groupName;

  final ScrollController _scrollController = ScrollController();
  void init(BuildContext context) {
    if (!_scrollController.hasListeners) {
      BlocProvider.of<GroupContributersCubit>(context)
          .getGroupContributers(context: context, key: groupKey, clear: true);
      dprint("Listener Added");
      _scrollController.addListener(() {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          BlocProvider.of<GroupContributersCubit>(context).getGroupContributers(
            context: context,
            key: groupKey,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$groupName Contributers",
          style: AppTextStyle.getMediumBoldStyle(color: AppColors.primaryColor),
        ),
      ),
      body: BlocBuilder<GroupContributersCubit, GroupContributersState>(
        builder: (context, state) {
          if (state is GroupContributersLoading) {
            return const Expanded(child: Center(child: Loader()));
          }
          if (state is GroupContributersError ||
              (state is GroupContributersLoaded &&
                  state.contributers.isEmpty)) {
            return const Expanded(
              child: Center(child: Text("There are no contributers to show")),
            );
          } else {
            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await BlocProvider.of<GroupContributersCubit>(context)
                      .getGroupContributers(
                          key: groupKey, context: context, clear: true);
                },
                child: Scrollbar(
                  thumbVisibility: true,
                  trackVisibility: true,
                  controller: _scrollController,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    controller: _scrollController,
                    itemCount:
                        (state as GroupContributersLoaded).contributers.length,
                    itemBuilder: (contetx, index) => Padding(
                      padding: EdgeInsets.only(
                          bottom:
                              index == state.contributers.length - 1 ? 200 : 0),
                      child: Card(
                        elevation: 5,
                        color: AppColors.primaryColor.withOpacity(0.5),
                        margin: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                onTap: () {
                                  AppRouter.navigateTo(
                                      context: context,
                                      destination: ProfileScreen(
                                        profileId: state.contributers[index].id,
                                      ));
                                },
                                leading: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      Links.baseUrlForImage +
                                          state.contributers[index].img),
                                ),
                                title: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        state.contributers[index].fullName,
                                        style: AppTextStyle.headerTextStyle()
                                            .copyWith(
                                                color: AppColors.thirdColor),
                                      ),
                                      10.space(),
                                      if (state.contributers[index].role == 1)
                                        Icon(
                                          Icons.admin_panel_settings_rounded,
                                          color: AppColors.lightGrey,
                                        )
                                    ],
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                      "@${state.contributers[index].accountName}",
                                      style: AppTextStyle.getSmallBoldStyle(
                                          color: AppColors.lightGrey)),
                                ),
                              ),
                              const CustomDivider(),
                              CardRow(
                                title: "Contributions",
                                description: state
                                    .contributers[index].contributionsNumber
                                    .toString(),
                                textStyle: AppTextStyle.getMediumBoldStyle(
                                    color: AppColors.lightGrey),
                              ),
                              CardRow(
                                title: "Last Contribution At",
                                description: state
                                    .contributers[index].lastContributionAt,
                                textStyle: AppTextStyle.getMediumBoldStyle(
                                    color: AppColors.lightGrey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
