import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/app_router.dart';
import 'package:github_clone_flutter/core/utils/enums.dart';
import 'package:github_clone_flutter/core/utils/extensions/space.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/cubit/files/all_files_cubit.dart';
import 'package:github_clone_flutter/cubit/files/files_loading_more_cubit.dart';
import 'package:github_clone_flutter/cubit/reports/filters/report_type_cubit.dart';
import 'package:github_clone_flutter/presentation/common_widgets/card_row.dart';
import 'package:github_clone_flutter/presentation/common_widgets/custom_text_form_field.dart';
import 'package:github_clone_flutter/presentation/common_widgets/divider.dart';
import 'package:github_clone_flutter/presentation/common_widgets/loader.dart';
import 'package:github_clone_flutter/presentation/screens/Files/widgets/filters.dart';
import 'package:github_clone_flutter/presentation/screens/reports/reports_screen.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';

class AllFilesScreen extends StatelessWidget {
  AllFilesScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  void init(BuildContext context) {
    BlocProvider.of<ReportTypeCubit>(context).changeType(Report.file);
    if (!_scrollController.hasListeners) {
      BlocProvider.of<AllFilesCubit>(context).reset();
      BlocProvider.of<AllFilesCubit>(context)
          .getAllFiles(context: context, name: "", clear: true);
      dprint("Listener Added");
      _scrollController.addListener(() {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          BlocProvider.of<AllFilesCubit>(context).getAllFiles(
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
          'All Files',
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
              BlocProvider.of<AllFilesCubit>(context)
                  .getAllFiles(context: context, name: value, clear: true);
            },
          ),
          ExpansionTile(
            title: Text(
              'Filters',
              style:
                  AppTextStyle.getSmallBoldStyle(color: AppColors.primaryColor),
            ),
            children: [
              FilesFilters(nameController: _nameController),
            ],
          ),
          BlocBuilder<AllFilesCubit, AllFilesState>(
            builder: (context, state) {
              if (state is AllFilesLoading) {
                return const Expanded(child: Center(child: Loader()));
              }
              if (state is AllFilesError ||
                  (state is AllFilesLoaded && state.files.isEmpty)) {
                return const Expanded(
                  child: Center(child: Text("There are no Files to show")),
                );
              } else {
                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await BlocProvider.of<AllFilesCubit>(context)
                                .getAllFiles(
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
                              itemCount: (state as AllFilesLoaded).files.length,
                              itemBuilder: (contetx, index) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: index == state.files.length - 1
                                        ? 200
                                        : 0),
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
                                                state.files[index].name,
                                                style: AppTextStyle
                                                        .headerTextStyle()
                                                    .copyWith(
                                                        color: AppColors
                                                            .thirdColor),
                                              ),
                                            ),
                                            Tooltip(
                                              message: "Reports",
                                              child: IconButton(
                                                onPressed: () {
                                                  BlocProvider.of<
                                                              ReportTypeCubit>(
                                                          context)
                                                      .changeType(Report.file);
                                                  AppRouter.navigateTo(
                                                      context: context,
                                                      destination:
                                                          ReportsScreen(
                                                              keyString: state
                                                                  .files[index]
                                                                  .fileKey));
                                                },
                                                icon: const Icon(
                                                  Icons.file_copy_rounded,
                                                  color: AppColors.thirdColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          child: Text(state.files[index].desc,
                                              style: AppTextStyle
                                                  .getMediumBoldStyle(
                                                      color:
                                                          AppColors.lightGrey)),
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
                                                    title: "Created At",
                                                    description: state
                                                        .files[index].createdAt,
                                                    textStyle: AppTextStyle
                                                        .getMediumBoldStyle(
                                                            color: AppColors
                                                                .lightGrey),
                                                  ),
                                                  CardRow(
                                                    title: "Created By",
                                                    description: state
                                                        .files[index].createdBy,
                                                    textStyle: AppTextStyle
                                                        .getMediumBoldStyle(
                                                            color: AppColors
                                                                .lightGrey),
                                                  ),
                                                  CardRow(
                                                    title: "Group name",
                                                    description: state
                                                        .files[index].groupName,
                                                    textStyle: AppTextStyle
                                                        .getMediumBoldStyle(
                                                            color: AppColors
                                                                .lightGrey),
                                                  ),
                                                  CardRow(
                                                    title: "Type",
                                                    description:
                                                        state.files[index].type,
                                                    textStyle: AppTextStyle
                                                        .getMediumBoldStyle(
                                                            color: AppColors
                                                                .lightGrey),
                                                  ),
                                                  CardRow(
                                                    title: "Size",
                                                    description:
                                                        state.files[index].size,
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
                                                    title: "Reserved By",
                                                    description: state
                                                        .files[index]
                                                        .reservedByName,
                                                    textStyle: AppTextStyle
                                                        .getMediumBoldStyle(
                                                            color: AppColors
                                                                .lightGrey),
                                                  ),
                                                  CardRow(
                                                    title: "Last Update",
                                                    description: state
                                                        .files[index]
                                                        .lastUpdate,
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
                      BlocBuilder<FilesLoadingMoreCubit, bool>(
                          builder: (context, state) =>
                              state ? const Loader() : const SizedBox.shrink())
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
