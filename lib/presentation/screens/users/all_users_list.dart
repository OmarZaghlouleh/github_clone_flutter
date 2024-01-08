import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/app_router.dart';
import 'package:github_clone_flutter/core/utils/enums.dart';
import 'package:github_clone_flutter/core/utils/extensions/space.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/cubit/reports/filters/report_type_cubit.dart';
import 'package:github_clone_flutter/cubit/users/users_cubit.dart';
import 'package:github_clone_flutter/cubit/users/users_loading_more_cubit.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/links.dart';
import 'package:github_clone_flutter/presentation/common_widgets/custom_text_form_field.dart';
import 'package:github_clone_flutter/presentation/common_widgets/divider.dart';
import 'package:github_clone_flutter/presentation/common_widgets/loader.dart';
import 'package:github_clone_flutter/presentation/screens/groups/widgets/filters.dart';
import 'package:github_clone_flutter/presentation/common_widgets/card_row.dart';
import 'package:github_clone_flutter/presentation/screens/profile/profile_screen.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';

class AllUsersListScreen extends StatelessWidget {
  AllUsersListScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  void init(BuildContext context) {
    if (!_scrollController.hasListeners) {
      BlocProvider.of<UsersCubit>(context)
          .getAllUsers(context: context, searchText: "", clear: true);
      dprint("Listener Added");
      _scrollController.addListener(() {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          BlocProvider.of<UsersCubit>(context).getAllUsers(
            context: context,
            searchText: _nameController.text.trim(),
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
          'All Users',
          style: AppTextStyle.getMediumBoldStyle(color: AppColors.primaryColor),
        ),
      ),
      body: Column(
        children: [
          CustomTextFormField(
            label: "Search",
            textInputType: TextInputType.text,
            controller: _nameController,
            textInputAction: TextInputAction.search,
            onSubmit: (value) {
              BlocProvider.of<UsersCubit>(context).getAllUsers(
                  context: context, searchText: value, clear: true);
            },
          ),
          BlocBuilder<UsersCubit, UsersState>(
            builder: (context, state) {
              if (state is UsersLoading) {
                return const Expanded(child: Center(child: Loader()));
              }
              if (state is UsersError ||
                  (state is UsersLoaded && state.users.isEmpty)) {
                return const Expanded(
                  child: Center(child: Text("There are no users to show")),
                );
              } else {
                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await BlocProvider.of<UsersCubit>(context)
                                .getAllUsers(
                                    searchText: _nameController.text.trim(),
                                    context: context,
                                    clear: true);
                          },
                          child: Scrollbar(
                            thumbVisibility: true,
                            trackVisibility: true,
                            controller: _scrollController,
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              controller: _scrollController,
                              itemCount: (state as UsersLoaded).users.length,
                              itemBuilder: (contetx, index) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: index == state.users.length - 1
                                        ? 200
                                        : 0),
                                child: InkWell(
                                  onTap: () {
                                    AppRouter.navigateTo(
                                        context: context,
                                        destination: ProfileScreen(
                                            profileId: state.users[index].id));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    color:
                                        AppColors.primaryColor.withOpacity(0.5),
                                    margin: const EdgeInsets.all(8),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              AppRouter.navigateTo(
                                                  context: context,
                                                  destination: ProfileScreen(
                                                    profileId:
                                                        state.users[index].id,
                                                  ));
                                            },
                                            leading: CircleAvatar(
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                      Links.baseUrlForImage +
                                                          state.users[index]
                                                              .img),
                                            ),
                                            title: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    state.users[index].fullName,
                                                    style: AppTextStyle
                                                            .headerTextStyle()
                                                        .copyWith(
                                                            color: AppColors
                                                                .thirdColor),
                                                  ),
                                                  10.space(),
                                                  if (state.users[index].role ==
                                                      1)
                                                    Icon(
                                                      Icons
                                                          .admin_panel_settings_rounded,
                                                      color:
                                                          AppColors.lightGrey,
                                                    )
                                                ],
                                              ),
                                            ),
                                            subtitle: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Text(
                                                  "@${state.users[index].accountName}",
                                                  style: AppTextStyle
                                                      .getSmallBoldStyle(
                                                          color: AppColors
                                                              .lightGrey)),
                                            ),
                                          ),
                                          const CustomDivider(),
                                          CardRow(
                                            title: "Role",
                                            description:
                                                state.users[index].roleName,
                                            textStyle:
                                                AppTextStyle.getMediumBoldStyle(
                                                    color: AppColors.lightGrey),
                                          ),
                                          CardRow(
                                            title: "Contributions",
                                            description: state.users[index]
                                                .contributionsNumber
                                                .toString(),
                                            textStyle:
                                                AppTextStyle.getMediumBoldStyle(
                                                    color: AppColors.lightGrey),
                                          ),
                                          CardRow(
                                            title: "Groups",
                                            description: state
                                                .users[index].groupsCount
                                                .toString(),
                                            textStyle:
                                                AppTextStyle.getMediumBoldStyle(
                                                    color: AppColors.lightGrey),
                                          ),
                                          CardRow(
                                            title: "Commits",
                                            description: state
                                                .users[index].commitsCount
                                                .toString(),
                                            textStyle:
                                                AppTextStyle.getMediumBoldStyle(
                                                    color: AppColors.lightGrey),
                                          ),
                                          CardRow(
                                            title: "Commits this year",
                                            description: state
                                                .users[index].commitsThisYear
                                                .toString(),
                                            textStyle:
                                                AppTextStyle.getMediumBoldStyle(
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
                        ),
                      ),
                      BlocBuilder<UsersLoadingMoreCubit, bool>(
                          builder: (context, state) => state
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Loader(),
                                )
                              : const SizedBox.shrink()),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
