import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/app_router.dart';
import 'package:github_clone_flutter/core/utils/constants.dart';
import 'package:github_clone_flutter/core/utils/enums.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/core/utils/extensions/space.dart';
import 'package:github_clone_flutter/cubit/files/files_list_cubit.dart';
import 'package:github_clone_flutter/cubit/reports/filters/report_type_cubit.dart';
import 'package:github_clone_flutter/presentation/screens/files/widgets/upload_files_widget.dart';
import 'package:github_clone_flutter/presentation/screens/reports/reports_screen.dart';

import '../../../../core/utils/strings_manager.dart';
import '../../../../cubit/check_out/check_out_cubit.dart';
import '../../../../data/data_resource/local_resource/shared_preferences.dart';
import '../../../../domain/models/file_model.dart';
import '../../../common_widgets/confirm_dialog.dart';
import '../../../common_widgets/row_info_text_span.dart';
import '../../../style/app_colors.dart';
import '../../../style/app_text_style.dart';

Widget fileCard(
    BuildContext context,
    FileModel fileModel,
    int userId,
    int orderSelectedOption,
    int descSelectedOption,
    TextEditingController searchController,
    String groupKey) {
  return BlocConsumer<CheckOutCubit, CheckOutState>(
    builder: (context, state) {
      return Wrap(
        // mainAxisSize: MainAxisSize.max,
        children: [
          BlocBuilder<FilesListCubit, FilesListState>(
              builder: (context, state) {
            if (state is FilesListLoaded) {
              return Checkbox(
                value: state.selectedFilesMapToDownload[fileModel.fileKey] ??
                    false,
                onChanged: (value) {
                  if (value != null) {
                    // checkBoxValue = value;
                    BlocProvider.of<FilesListCubit>(context)
                        .changeSelectedFileToDownload(fileModel.fileKey, value);
                  }
                },
              );
            }
            return 32.space();
          }),
          Padding(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: PopupMenuButton(
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: AppColors.secondaryColor,
                                ),
                                color: AppColors.thirdColor.withOpacity(0.9),
                                itemBuilder: (context) => [
                                  if (fileModel.reservedBy != 0 &&
                                      LocalResource.sharedPreferences
                                              .getInt('userId') ==
                                          fileModel.reservedBy)
                                    PopupMenuItem(
                                      value: StringManager.edit,
                                      child: Text(
                                        StringManager.edit,
                                        style: const TextStyle(
                                            color: AppColors.secondaryColor),
                                      ),
                                    ),
                                  if (fileModel.reservedBy != 0 &&
                                      LocalResource.sharedPreferences
                                              .getInt('userId') ==
                                          fileModel.reservedBy)
                                    PopupMenuItem(
                                      value:
                                          StringManager.cancelFileReservation,
                                      child: Text(
                                        StringManager.cancelFileReservation,
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
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return UploadFileWidget(
                                          Key: fileModel.fileKey,
                                          type: 'replace',
                                          userId: userId,
                                          orderSelectedOption:
                                              orderSelectedOption,
                                          descSelectedOption:
                                              descSelectedOption,
                                          searchController: searchController,
                                          groupKey: groupKey,
                                        );
                                      },
                                    );
                                  } else if (newVal ==
                                      StringManager.cancelFileReservation) {
                                    BlocProvider.of<CheckOutCubit>(context)
                                        .checkOut(
                                            fileKey: fileModel.fileKey,
                                            context: context);
                                  } else if (newVal == StringManager.delete) {
                                    if (await showConfirmDialog(
                                        context: context,
                                        contentText:
                                            "Are you sure that you want to delete the file?")) {
                                      BlocProvider.of<FilesListCubit>(context)
                                          .deleteFile(
                                              context: context,
                                              fileKey: fileModel.fileKey);
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                          if (LocalResource.sharedPreferences
                                  .getInt('roleId') ==
                              1)
                            Tooltip(
                              message: "Reports",
                              child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<ReportTypeCubit>(context)
                                      .changeType(Report.file);
                                  AppRouter.navigateTo(
                                      context: context,
                                      destination: ReportsScreen(
                                          keyString: fileModel.fileKey));
                                },
                                icon: const Icon(
                                  Icons.file_copy_rounded,
                                  color: AppColors.thirdColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  fileModel.name,
                                  style: AppTextStyle.getMediumBoldStyle(
                                      color: AppColors.lightGrey),
                                ),
                              ),
                              Text(
                                " ${fileModel.size}",
                                style: AppTextStyle.getMediumBoldStyle(
                                    color: AppColors.secondaryColor),
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
          ),
        ],
      );
    },
    listener: (BuildContext context, CheckOutState state) {
      if (state is CheckOutLoadedState) {
        BlocProvider.of<FilesListCubit>(context).reset();
        BlocProvider.of<FilesListCubit>(context).getFilesList(
            userId: userId,
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
            name: searchController.text.trim(),
            key: groupKey);
      }
    },
  );
}
