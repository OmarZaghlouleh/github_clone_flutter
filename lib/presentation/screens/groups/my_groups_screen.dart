import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/cubit/group/my_groups_cubit.dart';
import 'package:github_clone_flutter/domain/models/group_model.dart';
import 'package:github_clone_flutter/domain/models/profile_model.dart';
import 'package:github_clone_flutter/presentation/common_widgets/row_info_text_span.dart';
import 'package:github_clone_flutter/presentation/screens/groups/widgets/group_card.dart';

import '../../../core/utils/strings_manager.dart';
import '../../../data/data_resource/remote_resource/links.dart';
import '../../common_widgets/custom_text_form_field.dart';
import '../../common_widgets/empty_widget.dart';
import '../../common_widgets/form_header.dart';
import '../../common_widgets/info_row_component.dart';
import '../../common_widgets/loader.dart';
import '../../style/app_colors.dart';
import '../../style/app_text_style.dart';
import '../auth/widgets/text_field_component.dart';

class MyGroupsScreen extends StatefulWidget {
  const MyGroupsScreen({super.key, this.userId = -1});
  final int userId;

  @override
  State<MyGroupsScreen> createState() => _MyGroupsScreenState();
}

class _MyGroupsScreenState extends State<MyGroupsScreen> {
  final listViewController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      BlocProvider.of<MyGroupsCubit>(context).reset();
      BlocProvider.of<MyGroupsCubit>(context).getMyGroups(
          userId: widget.userId,
          context: context,
          order: "",
          desc: "",
          name: searchController.text.trim());

      listViewController.addListener(() {
        dprint(listViewController.position.extentAfter <= 0);
        // if (listViewController.position.maxScrollExtent ==
        //     listViewController.offset)
        if (listViewController.position.extentAfter <= 0 ||
            listViewController.position.maxScrollExtent ==
                listViewController.offset) {
          BlocProvider.of<MyGroupsCubit>(context).getMyGroups(
              userId: widget.userId,
              context: context,
              order: (orderSelectedOption == 1)
                  ? "name"
                  : (orderSelectedOption == 2)
                      ? "created_at"
                      : "",
              desc: (descSelectedOption == 1)
                  ? "desc"
                  : (descSelectedOption == 2)
                      ? "asc"
                      : "",
              name: searchController.text.trim());
        }
      });
    });
  }

  @override
  void dispose() {
    listViewController.dispose();
    super.dispose();
  }

  int orderSelectedOption = 3;
  int descSelectedOption = 3;

  List groups = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Groups",
            style: AppTextStyle.getMediumBoldStyle(
                color: AppColors.secondaryColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFieldComponent(
                        controller: searchController,
                        title: "Search by name",
                        validate: () {},
                        formatters: const [],
                        textInputType: TextInputType.name,
                        textInputAction: TextInputAction.search,
                        onFieldSubmitted: () {
                          BlocProvider.of<MyGroupsCubit>(context).reset();
                          BlocProvider.of<MyGroupsCubit>(context).getMyGroups(
                              userId: widget.userId,
                              context: context,
                              order: (orderSelectedOption == 1)
                                  ? "name"
                                  : (orderSelectedOption == 2)
                                      ? "created_at"
                                      : "",
                              desc: (descSelectedOption == 1)
                                  ? "desc"
                                  : (descSelectedOption == 2)
                                      ? "asc"
                                      : "",
                              name: searchController.text.trim());
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                    title: const FormHeader(
                      title: "Order by",
                    ),
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: [
                                Radio<int>(
                                  value: 1,
                                  groupValue: orderSelectedOption,
                                  activeColor: AppColors.primaryColor,
                                  fillColor: MaterialStateProperty.all(
                                      AppColors.primaryColor),
                                  splashRadius: 25,
                                  onChanged: (int? value) {
                                    setState(() {
                                      orderSelectedOption = value!;
                                    });
                                    BlocProvider.of<MyGroupsCubit>(context)
                                        .reset();
                                    BlocProvider.of<MyGroupsCubit>(context)
                                        .getMyGroups(
                                            userId: widget.userId,
                                            context: context,
                                            order: (orderSelectedOption == 1)
                                                ? "name"
                                                : (orderSelectedOption == 2)
                                                    ? "created_at"
                                                    : "",
                                            desc: (descSelectedOption == 1)
                                                ? "desc"
                                                : (descSelectedOption == 2)
                                                    ? "asc"
                                                    : "",
                                            name: searchController.text.trim());
                                  },
                                ),
                                Text(
                                  'name',
                                  style: AppTextStyle.getSmallBoldStyle(
                                      color: AppColors.secondaryColor),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Radio<int>(
                                  value: 2,
                                  groupValue: orderSelectedOption,
                                  activeColor: AppColors.primaryColor,
                                  fillColor: MaterialStateProperty.all(
                                      AppColors.primaryColor),
                                  splashRadius: 25,
                                  onChanged: (int? value) {
                                    // FocusScope.of(context).unfocus();
                                    setState(() {
                                      orderSelectedOption = value!;
                                    });
                                    BlocProvider.of<MyGroupsCubit>(context)
                                        .reset();
                                    BlocProvider.of<MyGroupsCubit>(context)
                                        .getMyGroups(
                                            userId: widget.userId,
                                            context: context,
                                            order: (orderSelectedOption == 1)
                                                ? "name"
                                                : (orderSelectedOption == 2)
                                                    ? "created_at"
                                                    : "",
                                            desc: (descSelectedOption == 1)
                                                ? "desc"
                                                : (descSelectedOption == 2)
                                                    ? "asc"
                                                    : "",
                                            name: searchController.text.trim());
                                  },
                                ),
                                Text(
                                  "Created at",
                                  style: AppTextStyle.getSmallBoldStyle(
                                      color: AppColors.secondaryColor),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Radio<int>(
                                  value: 3,
                                  groupValue: orderSelectedOption,
                                  activeColor: AppColors.primaryColor,
                                  fillColor: MaterialStateProperty.all(
                                      AppColors.primaryColor),
                                  splashRadius: 25,
                                  onChanged: (int? value) {
                                    setState(() {
                                      orderSelectedOption = value!;
                                    });
                                    BlocProvider.of<MyGroupsCubit>(context)
                                        .reset();
                                    BlocProvider.of<MyGroupsCubit>(context)
                                        .getMyGroups(
                                            userId: widget.userId,
                                            context: context,
                                            order: (orderSelectedOption == 1)
                                                ? "name"
                                                : (orderSelectedOption == 2)
                                                    ? "created_at"
                                                    : "",
                                            desc: (descSelectedOption == 1)
                                                ? "desc"
                                                : (descSelectedOption == 2)
                                                    ? "asc"
                                                    : "",
                                            name: searchController.text.trim());
                                  },
                                ),
                                Text(
                                  'without filter',
                                  style: AppTextStyle.getSmallBoldStyle(
                                      color: AppColors.secondaryColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: [
                                Radio<int>(
                                  value: 1,
                                  groupValue: descSelectedOption,
                                  activeColor: AppColors.primaryColor,
                                  fillColor: MaterialStateProperty.all(
                                      AppColors.primaryColor),
                                  splashRadius: 25,
                                  onChanged: (int? value) {
                                    setState(() {
                                      descSelectedOption = value!;
                                    });
                                    BlocProvider.of<MyGroupsCubit>(context)
                                        .reset();
                                    BlocProvider.of<MyGroupsCubit>(context)
                                        .getMyGroups(
                                            userId: widget.userId,
                                            context: context,
                                            order: (orderSelectedOption == 1)
                                                ? "name"
                                                : (orderSelectedOption == 2)
                                                    ? "created_at"
                                                    : "",
                                            desc: (descSelectedOption == 1)
                                                ? "desc"
                                                : (descSelectedOption == 2)
                                                    ? "asc"
                                                    : "",
                                            name: searchController.text.trim());
                                  },
                                ),
                                Text(
                                  'Descending',
                                  style: AppTextStyle.getSmallBoldStyle(
                                      color: AppColors.secondaryColor),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Radio<int>(
                                  value: 2,
                                  groupValue: descSelectedOption,
                                  activeColor: AppColors.primaryColor,
                                  fillColor: MaterialStateProperty.all(
                                      AppColors.primaryColor),
                                  splashRadius: 25,
                                  onChanged: (int? value) {
                                    // FocusScope.of(context).unfocus();
                                    setState(() {
                                      descSelectedOption = value!;
                                    });
                                    BlocProvider.of<MyGroupsCubit>(context)
                                        .reset();
                                    BlocProvider.of<MyGroupsCubit>(context)
                                        .getMyGroups(
                                            userId: widget.userId,
                                            context: context,
                                            order: (orderSelectedOption == 1)
                                                ? "name"
                                                : (orderSelectedOption == 2)
                                                    ? "created_at"
                                                    : "",
                                            desc: (descSelectedOption == 1)
                                                ? "desc"
                                                : (descSelectedOption == 2)
                                                    ? "asc"
                                                    : "",
                                            name: searchController.text.trim());
                                  },
                                ),
                                Text(
                                  "Asccending",
                                  style: AppTextStyle.getSmallBoldStyle(
                                      color: AppColors.secondaryColor),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Radio<int>(
                                  value: 3,
                                  groupValue: descSelectedOption,
                                  activeColor: AppColors.primaryColor,
                                  fillColor: MaterialStateProperty.all(
                                      AppColors.primaryColor),
                                  splashRadius: 25,
                                  onChanged: (int? value) {
                                    setState(() {
                                      descSelectedOption = value!;
                                    });
                                    BlocProvider.of<MyGroupsCubit>(context)
                                        .reset();
                                    BlocProvider.of<MyGroupsCubit>(context)
                                        .getMyGroups(
                                            userId: widget.userId,
                                            context: context,
                                            order: (orderSelectedOption == 1)
                                                ? "name"
                                                : (orderSelectedOption == 2)
                                                    ? "created_at"
                                                    : "",
                                            desc: (descSelectedOption == 1)
                                                ? "desc"
                                                : (descSelectedOption == 2)
                                                    ? "asc"
                                                    : "",
                                            name: searchController.text.trim());
                                  },
                                ),
                                Text(
                                  'without filter',
                                  style: AppTextStyle.getSmallBoldStyle(
                                      color: AppColors.secondaryColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
              BlocBuilder<MyGroupsCubit, MyGroupsState>(
                builder: (context, state) {
                  if (state is MyGroupsLoaded || state is MyGroupsLoading) {
                    dlog("yeeeeeeeees");

                    if (state is MyGroupsLoaded) {
                      groups = (state).myGroups;

                      dprint(groups);
                    }
                    return Column(
                      children: [
                        if (groups.isNotEmpty)
                          RefreshIndicator(
                            onRefresh: () async {
                              BlocProvider.of<MyGroupsCubit>(context).reset();
                              BlocProvider.of<MyGroupsCubit>(context)
                                  .getMyGroups(
                                      userId: widget.userId,
                                      context: context,
                                      order: (orderSelectedOption == 1)
                                          ? "name"
                                          : (orderSelectedOption == 2)
                                              ? "created_at"
                                              : "",
                                      desc: (descSelectedOption == 1)
                                          ? "desc"
                                          : (descSelectedOption == 2)
                                              ? "asc"
                                              : "",
                                      name: searchController.text.trim());
                            },
                            child: ListView.builder(
                              primary: false,
                              controller: listViewController,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              itemCount: groups.length,
                              itemBuilder: ((context, index) {
                                if (index < groups.length) {
                                  return groupCard(context, groups[index]);
                                } else {
                                  return const Center(child: Loader());
                                }
                              }),
                            ),
                          ),
                        state is MyGroupsLoading
                            ? const Center(
                                child: Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Loader(),
                              ))
                            : TextButton.icon(
                                onPressed: () {
                                  BlocProvider.of<MyGroupsCubit>(context)
                                      .getMyGroups(
                                          userId: widget.userId,
                                          context: context,
                                          order: (orderSelectedOption == 1)
                                              ? "name"
                                              : (orderSelectedOption == 2)
                                                  ? "created_at"
                                                  : "",
                                          desc: (descSelectedOption == 1)
                                              ? "desc"
                                              : (descSelectedOption == 2)
                                                  ? "asc"
                                                  : "",
                                          name: searchController.text.trim());
                                },
                                icon: const Icon(
                                  Icons.cloud_download_rounded,
                                  size: 50,
                                ),
                                label: Text(
                                  StringManager.loadMoreData,
                                  style: AppTextStyle.getSmallBoldStyle(
                                      color: AppColors.secondaryColor),
                                )),
                      ],
                    );
                  }
                  if (state is MyGroupsError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            (state).myGroupsErrorMessage,
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
                              BlocProvider.of<MyGroupsCubit>(context).reset();
                              BlocProvider.of<MyGroupsCubit>(context)
                                  .getMyGroups(
                                      userId: widget.userId,
                                      context: context,
                                      order: (orderSelectedOption == 1)
                                          ? "name"
                                          : (orderSelectedOption == 2)
                                              ? "created_at"
                                              : "",
                                      desc: (descSelectedOption == 1)
                                          ? "desc"
                                          : (descSelectedOption == 2)
                                              ? "asc"
                                              : "",
                                      name: searchController.text.trim());
                            },
                          ),
                        ],
                      ),
                    );
                  }
                  return const EmptyWidget();
                },
              ),
            ],
          ),
        ));
  }
}
