import 'package:flutter/material.dart';
import 'package:github_clone_flutter/core/utils/constants.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/presentation/screens/groups/widgets/contributers_card.dart';

import '../../../../core/utils/strings_manager.dart';
import '../../../../domain/models/file_model.dart';
import '../../../../domain/models/group_model.dart';
import '../../../common_widgets/confirm_dialog.dart';
import '../../../common_widgets/row_info_text_span.dart';
import '../../../style/app_colors.dart';
import '../../../style/app_text_style.dart';

Widget fileCard(BuildContext context, FileModel fileModel) {
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
                        value: StringManager.edit,
                        child: Text(
                          StringManager.edit,
                          style:
                              const TextStyle(color: AppColors.secondaryColor),
                        ),
                      ),
                      PopupMenuItem(
                        value: StringManager.delete,
                        child: Text(
                          StringManager.delete,
                          style: const TextStyle(color: AppColors.errorColor),
                        ),
                      ),
                    ],
                    onSelected: (newVal) async {
                      if (newVal == StringManager.edit) {
                        //TODO: wael
                      } else if (newVal == StringManager.delete) {
                        if (await showConfirmDialog(
                            context: context,
                            contentText:
                                "Are you sure that you want to delete the file?")) {}
                      }
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Text(
                              fileModel.name,
                              style: AppTextStyle.getMediumBoldStyle(
                                  color: AppColors.lightGrey),
                            ),
                            Text(
                              " ${fileModel.size} B",
                              style: AppTextStyle.getMediumBoldStyle(
                                  color: AppColors.secondaryColor),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          fileModel.desc,
                          style: AppTextStyle.getMediumBoldStyle(
                              color: AppColors.secondaryColor),
                        ),
                      ),
                      RowInfoTextSpan(
                          label1: "Group", label2: fileModel.groupName),
                      RowInfoTextSpan(
                          label1: "Reserved by",
                          label2: fileModel.reservedByName),
                      Row(
                        children: [
                          RowInfoTextSpan(
                            label1: "Created at",
                            label2: fileModel.createdAt,
                          ),
                          (1.mqWidth(context) >= bigScreen)
                              ? RowInfoTextSpan(
                                  label1: "Updated at",
                                  label2: fileModel.lastUpdate,
                                )
                              : Container(),
                        ],
                      ),
                      (1.mqWidth(context) < bigScreen)
                          ? RowInfoTextSpan(
                              label1: "Updated at",
                              label2: fileModel.lastUpdate,
                            )
                          : Container(),
                    ],
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
