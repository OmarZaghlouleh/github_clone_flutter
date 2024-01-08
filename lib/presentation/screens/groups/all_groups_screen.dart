import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/app_router.dart';
import 'package:github_clone_flutter/core/utils/enums.dart';
import 'package:github_clone_flutter/core/utils/extensions/space.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/cubit/group/all_groups_cubit.dart';
import 'package:github_clone_flutter/cubit/group/group_loading_more_cubit.dart';
import 'package:github_clone_flutter/cubit/reports/filters/report_type_cubit.dart';
import 'package:github_clone_flutter/presentation/common_widgets/custom_text_form_field.dart';
import 'package:github_clone_flutter/presentation/common_widgets/divider.dart';
import 'package:github_clone_flutter/presentation/common_widgets/loader.dart';
import 'package:github_clone_flutter/presentation/screens/files/files_list_screen.dart';
import 'package:github_clone_flutter/presentation/screens/groups/group_contributers_screen.dart';
import 'package:github_clone_flutter/presentation/screens/groups/widgets/filters.dart';
import 'package:github_clone_flutter/presentation/common_widgets/card_row.dart';
import 'package:github_clone_flutter/presentation/screens/reports/reports_screen.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';

class AllGroupsScreen extends StatelessWidget {
  AllGroupsScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  void init(BuildContext context) {
    BlocProvider.of<ReportTypeCubit>(context).changeType(Report.group);

    if (!_scrollController.hasListeners) {
      BlocProvider.of<AllGroupsCubit>(context).reset();
      BlocProvider.of<AllGroupsCubit>(context)
          .getAllGroups(context: context, name: "", clear: true);
      dprint("Listener Added");
      _scrollController.addListener(() {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          BlocProvider.of<AllGroupsCubit>(context).getAllGroups(
            context: context,
            name: _nameController.text.trim(),
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
          'All Groups',
          style: AppTextStyle.getMediumBoldStyle(color: AppColors.primaryColor),
        ),
      ),
      body: Column(
        children: [
          CustomTextFormField(
            label: "Name",
            textInputType: TextInputType.text,
            controller: _nameController,
            textInputAction: TextInputAction.search,
            onSubmit: (value) {
              BlocProvider.of<AllGroupsCubit>(context)
                  .getAllGroups(context: context, name: value, clear: true);
            },
          ),
          ExpansionTile(
            title: Text(
              'Filters',
              style:
                  AppTextStyle.getSmallBoldStyle(color: AppColors.primaryColor),
            ),
            children: [
              GroupsFilters(nameController: _nameController),
            ],
          ),
          BlocBuilder<AllGroupsCubit, AllGroupsState>(
            builder: (context, state) {
              if (state is AllGroupsLoading) {
                return const Expanded(child: Center(child: Loader()));
              }
              if (state is AllGroupsError ||
                  (state is AllGroupsLoaded && state.groups.isEmpty)) {
                return const Expanded(
                  child: Center(child: Text("There are no groups to show")),
                );
              } else {
                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await BlocProvider.of<AllGroupsCubit>(context)
                                .getAllGroups(
                                    name: _nameController.text.trim(),
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
                              itemCount:
                                  (state as AllGroupsLoaded).groups.length,
                              itemBuilder: (contetx, index) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: index == state.groups.length - 1
                                        ? 200
                                        : 0),
                                child: InkWell(
                                  onTap: () {
                                    AppRouter.navigateTo(
                                        context: context,
                                        destination: FilesListScreen(
                                            groupKey:
                                                state.groups[index].groupKey));
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  state.groups[index].name,
                                                  style: AppTextStyle
                                                          .headerTextStyle()
                                                      .copyWith(
                                                          color: AppColors
                                                              .thirdColor),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Tooltip(
                                                    message: "Reports",
                                                    child: IconButton(
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    ReportTypeCubit>(
                                                                context)
                                                            .changeType(
                                                                Report.group);
                                                        AppRouter.navigateTo(
                                                            context: context,
                                                            destination: ReportsScreen(
                                                                keyString: state
                                                                    .groups[
                                                                        index]
                                                                    .groupKey));
                                                      },
                                                      icon: const Icon(
                                                        Icons.file_copy_rounded,
                                                        color: AppColors
                                                            .thirdColor,
                                                      ),
                                                    ),
                                                  ),
                                                  10.space(),
                                                  Tooltip(
                                                    message: "Contributers",
                                                    child: IconButton(
                                                      onPressed: () {
                                                        AppRouter.navigateTo(
                                                            context: context,
                                                            destination: GroupContributersScreen(
                                                                groupName: state
                                                                    .groups[
                                                                        index]
                                                                    .name,
                                                                groupKey: state
                                                                    .groups[
                                                                        index]
                                                                    .groupKey));
                                                      },
                                                      icon: const Icon(
                                                        Icons.group_rounded,
                                                        color: AppColors
                                                            .thirdColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            child: Text(
                                                state.groups[index].desc,
                                                style: AppTextStyle
                                                    .getMediumBoldStyle(
                                                        color: AppColors
                                                            .lightGrey)),
                                          ),
                                          const CustomDivider(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    CardRow(
                                                      title: "Created by",
                                                      description: state
                                                          .groups[index]
                                                          .createdBy,
                                                      textStyle: AppTextStyle
                                                          .getMediumBoldStyle(
                                                              color: AppColors
                                                                  .lightGrey),
                                                    ),
                                                    CardRow(
                                                      title: "Created At",
                                                      description: state
                                                          .groups[index]
                                                          .createdAt,
                                                      textStyle: AppTextStyle
                                                          .getMediumBoldStyle(
                                                              color: AppColors
                                                                  .lightGrey),
                                                    ),
                                                    CardRow(
                                                      title: "Contributers",
                                                      description: state
                                                          .groups[index]
                                                          .numberContributers
                                                          .length
                                                          .toString(),
                                                      textStyle: AppTextStyle
                                                          .getMediumBoldStyle(
                                                              color: AppColors
                                                                  .lightGrey),
                                                    ),
                                                    CardRow(
                                                      title: "Files",
                                                      description: state
                                                          .groups[index]
                                                          .numberFiles
                                                          .toString(),
                                                      textStyle: AppTextStyle
                                                          .getMediumBoldStyle(
                                                              color: AppColors
                                                                  .lightGrey),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    CardRow(
                                                      title: "Commits",
                                                      description: state
                                                          .groups[index]
                                                          .numberCommits
                                                          .toString(),
                                                      textStyle: AppTextStyle
                                                          .getMediumBoldStyle(
                                                              color: AppColors
                                                                  .lightGrey),
                                                    ),
                                                    CardRow(
                                                      title: "Last Commit",
                                                      description: state
                                                          .groups[index]
                                                          .lastCommit,
                                                      textStyle: AppTextStyle
                                                          .getMediumBoldStyle(
                                                              color: AppColors
                                                                  .lightGrey),
                                                    ),
                                                    CardRow(
                                                      title: "Last Commit By",
                                                      description: state
                                                          .groups[index]
                                                          .lastCommitBy,
                                                      textStyle: AppTextStyle
                                                          .getMediumBoldStyle(
                                                              color: AppColors
                                                                  .lightGrey),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
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
                      BlocBuilder<GroupLoadingMoreCubit, bool>(
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
