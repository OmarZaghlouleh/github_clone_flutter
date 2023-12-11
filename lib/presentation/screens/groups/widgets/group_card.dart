import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/presentation/screens/groups/group_contributers_screen.dart';
import 'package:github_clone_flutter/presentation/screens/groups/widgets/contributers_card.dart';

import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../cubit/group/my_groups_cubit.dart';
import '../../../../domain/models/group_model.dart';
import '../../../common_widgets/confirm_dialog.dart';
import '../../../common_widgets/row_info_text_span.dart';
import '../../../style/app_colors.dart';
import '../../../style/app_text_style.dart';
import '../../files/files_list_screen.dart';
import '../../group/update_group_screen.dart';

Widget groupCard(BuildContext context, GroupModel groupModel) {
  return InkWell(
    onTap: () {
      AppRouter.navigateTo(
          context: context,
          destination: FilesListScreen(
            groupKey: groupModel.groupKey,
          ));
    },
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 0.02.mqWidth(context),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: PopupMenuButton(
                          icon: const Icon(
                            Icons.more_vert,
                            color: AppColors.secondaryColor,
                          ),
                          color: AppColors.thirdColor.withOpacity(0.9),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: StringManager.download,
                              child: Text(
                                StringManager.download,
                                style: const TextStyle(
                                    color: AppColors.secondaryColor),
                              ),
                            ),
                            PopupMenuItem(
                              value: StringManager.edit,
                              child: Text(
                                StringManager.edit,
                                style: const TextStyle(
                                    color: AppColors.secondaryColor),
                              ),
                            ),
                            PopupMenuItem(
                              value: StringManager.delete,
                              child: Text(
                                StringManager.delete,
                                style: const TextStyle(
                                    color: AppColors.errorColor),
                              ),
                            ),
                          ],
                          onSelected: (newVal) async {
                            if (newVal == StringManager.edit) {
                              AppRouter.navigateTo(
                                  context: context,
                                  destination:  UpdateGroupScreen(groupKey:groupModel.groupKey ,));
                            } else if (newVal == StringManager.delete) {
                              if (await showConfirmDialog(
                                  context: context,
                                  contentText:
                                      "Are you sure that you want to delete the group?")) {
                                BlocProvider.of<MyGroupsCubit>(context)
                                    .deleteGroup(
                                        context: context,
                                        groupKey: groupModel.groupKey);
                              }
                            } else if (newVal == StringManager.download) {
                              BlocProvider.of<MyGroupsCubit>(context)
                                  .cloneGroup(
                                      context: context,
                                      groupKey: groupModel.groupKey,
                                      name: groupModel.name);
                            }
                          },
                        ),
                      ),
                    ),
                    Tooltip(
                      message: "Contributers",
                      child: IconButton(
                        onPressed: () {
                          AppRouter.navigateTo(
                              context: context,
                              destination: GroupContributersScreen(
                                  groupName: groupModel.name,
                                  groupKey: groupModel.groupKey));
                        },
                        icon: const Icon(
                          Icons.group_rounded,
                          color: AppColors.thirdColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            groupModel.name,
                            style: AppTextStyle.getMediumBoldStyle(
                                color: AppColors.lightGrey),
                          ),
                        ),
                        RowInfoTextSpan(
                            label1: "Files number",
                            label2: groupModel.numberFiles.toString()),
                        RowInfoTextSpan(
                            label1: "Last commit by",
                            label2: groupModel.lastCommitBy),
                        RowInfoTextSpan(
                            label1: "Commits number",
                            label2: groupModel.numberCommits.toString()),
                        RowInfoTextSpan(
                            label1: "Last commit",
                            label2: groupModel.lastCommit),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              groupModel.createdAt,
                              style: AppTextStyle.getSmallBoldStyle(
                                  color: AppColors.secondaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: groupModel.numberContributers
                                .map((e) => contributerCard(context, e))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    groupModel.desc,
                    style: AppTextStyle.getMediumBoldStyle(
                        color: AppColors.secondaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
