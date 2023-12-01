import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/cubit/group/my_groups_cubit.dart';
import 'package:github_clone_flutter/domain/models/group_model.dart';

import '../../../core/utils/strings_manager.dart';
import '../../common_widgets/custom_text_form_field.dart';
import '../../common_widgets/empty_widget.dart';
import '../../common_widgets/loader.dart';
import '../../style/app_colors.dart';
import '../../style/app_text_style.dart';
import '../auth/widgets/text_field_component.dart';

class MyGroupsScreen extends StatefulWidget {
  const MyGroupsScreen({super.key});

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
          context: context,
          order: "",
          desc: "",
          name: searchController.text.trim());

      listViewController.addListener(() {
        if (listViewController.position.maxScrollExtent ==
            listViewController.offset) {
          BlocProvider.of<MyGroupsCubit>(context).getMyGroups(
              context: context,
              order: "",
              desc: "",
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

  List<GroupModel> groups = [];
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
        body: Column(
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
                            context: context,
                            order: "",
                            desc: "",
                            name: searchController.text.trim());
                      },
                    ),
                  ),
                ],
              ),
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
                            BlocProvider.of<MyGroupsCubit>(context).getMyGroups(
                                context: context,
                                order: "",
                                desc: "",
                                name: searchController.text.trim());
                          },
                          child: ListView.builder(
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
                      // ElevatedButton(
                      //   onPressed: () {
                      //     if (state is MyGroupsLoaded) {
                      //       dprint(groups);
                      //     }
                      //   },
                      //   child: const Text("data"),
                      // ),
                      if (state is MyGroupsLoading)
                        const Center(child: Loader()),
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
                            BlocProvider.of<MyGroupsCubit>(context).getMyGroups(
                                context: context,
                                order: "",
                                desc: "",
                                name: searchController.text.trim());
                          },
                        ),
                      ],
                    ),
                  );
                }
                return const Text("No data"); //todo edit it when finish
                // const EmptyWidget();
              },
            ),
          ],
        ));
  }

  groupCard(BuildContext context, GroupModel groupModel) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 0.02.mqWdith(context),
            vertical: 0.01.mqHeight(context)),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor,
                  blurRadius: 30,
                  offset: const Offset(10, 15),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    groupModel.name,
                    style: AppTextStyle.getMediumBoldStyle(
                        color: AppColors.lightGrey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    groupModel.createdAt,
                    style: AppTextStyle.getMediumBoldStyle(
                        color: AppColors.secondaryColor),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          groupModel.desc,
                          style: AppTextStyle.getMediumBoldStyle(
                              color: AppColors.secondaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
