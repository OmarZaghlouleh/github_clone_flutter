import 'package:flutter/material.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/presentation/screens/groups/widgets/contributers_card.dart';

import '../../../../domain/models/group_model.dart';
import '../../../common_widgets/row_info_text_span.dart';
import '../../../style/app_colors.dart';
import '../../../style/app_text_style.dart';

Widget groupCard(BuildContext context, GroupModel groupModel) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 0.02.mqWidth(context), vertical: 0.01.mqHeight(context)),
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
                          label1: "Last commit", label2: groupModel.lastCommit),
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
  );
}
