import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/cubit/check_in/check_in_cubit.dart';
import 'package:github_clone_flutter/cubit/files/files_list_cubit.dart';
import 'package:github_clone_flutter/presentation/screens/files/widgets/file_card.dart';
import 'package:github_clone_flutter/presentation/screens/files/widgets/upload_files_widget.dart';
import '../../../core/utils/strings_manager.dart';
import '../../../domain/models/file_model.dart';
import '../../common_widgets/elevated_button_widget.dart';
import '../../common_widgets/empty_widget.dart';
import '../../common_widgets/form_header.dart';
import '../../common_widgets/loader.dart';
import '../../style/app_colors.dart';
import '../../style/app_text_style.dart';
import '../auth/widgets/text_field_component.dart';

class FilesListScreen extends StatefulWidget {
  const FilesListScreen({super.key, required this.groupKey, this.userId = -1});

  final int userId;

  final String groupKey;

  @override
  State<FilesListScreen> createState() => _FilesListScreenState();
}

class _FilesListScreenState extends State<FilesListScreen> {
  final listViewController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      BlocProvider.of<FilesListCubit>(context).reset();
      BlocProvider.of<FilesListCubit>(context).getFilesList(
          userId: widget.userId,
          context: context,
          order: "",
          desc: "",
          name: searchController.text.trim(),
          key: widget.groupKey);

      listViewController.addListener(() {
        dprint(listViewController.position.extentAfter <= 0);
        // if (listViewController.position.maxScrollExtent ==
        //     listViewController.offset)
        if (listViewController.position.extentAfter <= 0 ||
            listViewController.position.maxScrollExtent ==
                listViewController.offset) {
          BlocProvider.of<FilesListCubit>(context).getFilesList(
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
              name: searchController.text.trim(),
              key: "");
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

  List<FileModel> files = [];

  @override
  Widget build(BuildContext context) {
    final CheckInCubit checkInCubit = BlocProvider.of<CheckInCubit>(context);
    return BlocBuilder<CheckInCubit, CheckInState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: checkInCubit.selectFileKeys.values.isNotEmpty
                  ? Text(
                      '${checkInCubit.selectFileKeys.values.where(((k) => k.keys.first == true)).length} file selected')
                  : Text(
                      "Files",
                      style: AppTextStyle.getMediumBoldStyle(
                          color: AppColors.secondaryColor),
                    ),
              leading: checkInCubit.selectFileKeys.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        checkInCubit.selectFileKeys.clear();
                        checkInCubit.selectLongTab = false;
                       checkInCubit.emit(CheckInInitialState());
                      },
                    )
                  : null,
              actions: checkInCubit.selectFileKeys.isNotEmpty
                  ? [
                ElevatedButtonWidget(
                  widget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Reserve Files',
                        style: AppTextStyle.elevatedButtonTextStyle(),
                      ),
                      const Icon(Icons.check),
                    ],
                  ),
                  onPressed: () async {
                   await checkInCubit.checkIn(context: context);
                  },
                  buttonStyle:
                  Theme.of(context).elevatedButtonTheme.style,
                ),
              ]
                  : [
                      if (widget.groupKey.isNotEmpty)
                        ElevatedButtonWidget(
                          widget: Row(
                            children: [
                              Text(
                                'upload file',
                                style: AppTextStyle.elevatedButtonTextStyle(),
                              ),
                              const Icon(Icons.file_upload),
                            ],
                          ),
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return UploadFileWidget(
                                  Key: widget.groupKey,
                                  type: 'upload',
                                );
                              },
                            );
                          },
                          buttonStyle:
                              Theme.of(context).elevatedButtonTheme.style,
                        ),
                    ],
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
                              BlocProvider.of<FilesListCubit>(context).reset();
                              BlocProvider.of<FilesListCubit>(context)
                                  .getFilesList(
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
                                      name: searchController.text.trim(),
                                      key: widget.groupKey);
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
                                        BlocProvider.of<FilesListCubit>(context)
                                            .reset();
                                        BlocProvider.of<FilesListCubit>(context)
                                            .getFilesList(
                                                userId: widget.userId,
                                                context: context,
                                                order: (orderSelectedOption ==
                                                        1)
                                                    ? "name"
                                                    : (orderSelectedOption == 2)
                                                        ? "created_at"
                                                        : "",
                                                desc: (descSelectedOption == 1)
                                                    ? "desc"
                                                    : (descSelectedOption == 2)
                                                        ? "asc"
                                                        : "",
                                                name: searchController.text
                                                    .trim(),
                                                key: widget.groupKey);
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
                                        BlocProvider.of<FilesListCubit>(context)
                                            .reset();
                                        BlocProvider.of<FilesListCubit>(context)
                                            .getFilesList(
                                                userId: widget.userId,
                                                context: context,
                                                order: (orderSelectedOption ==
                                                        1)
                                                    ? "name"
                                                    : (orderSelectedOption == 2)
                                                        ? "created_at"
                                                        : "",
                                                desc: (descSelectedOption == 1)
                                                    ? "desc"
                                                    : (descSelectedOption == 2)
                                                        ? "asc"
                                                        : "",
                                                name: searchController.text
                                                    .trim(),
                                                key: widget.groupKey);
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
                                        BlocProvider.of<FilesListCubit>(context)
                                            .reset();
                                        BlocProvider.of<FilesListCubit>(context)
                                            .getFilesList(
                                                userId: widget.userId,
                                                context: context,
                                                order: (orderSelectedOption ==
                                                        1)
                                                    ? "name"
                                                    : (orderSelectedOption == 2)
                                                        ? "created_at"
                                                        : "",
                                                desc: (descSelectedOption == 1)
                                                    ? "desc"
                                                    : (descSelectedOption == 2)
                                                        ? "asc"
                                                        : "",
                                                name: searchController.text
                                                    .trim(),
                                                key: widget.groupKey);
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
                                        BlocProvider.of<FilesListCubit>(context)
                                            .reset();
                                        BlocProvider.of<FilesListCubit>(context)
                                            .getFilesList(
                                                userId: widget.userId,
                                                context: context,
                                                order: (orderSelectedOption ==
                                                        1)
                                                    ? "name"
                                                    : (orderSelectedOption == 2)
                                                        ? "created_at"
                                                        : "",
                                                desc: (descSelectedOption == 1)
                                                    ? "desc"
                                                    : (descSelectedOption == 2)
                                                        ? "asc"
                                                        : "",
                                                name: searchController.text
                                                    .trim(),
                                                key: widget.groupKey);
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
                                        BlocProvider.of<FilesListCubit>(context)
                                            .reset();
                                        BlocProvider.of<FilesListCubit>(context)
                                            .getFilesList(
                                                userId: widget.userId,
                                                context: context,
                                                order: (orderSelectedOption ==
                                                        1)
                                                    ? "name"
                                                    : (orderSelectedOption == 2)
                                                        ? "created_at"
                                                        : "",
                                                desc: (descSelectedOption == 1)
                                                    ? "desc"
                                                    : (descSelectedOption == 2)
                                                        ? "asc"
                                                        : "",
                                                name: searchController.text
                                                    .trim(),
                                                key: widget.groupKey);
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
                                        BlocProvider.of<FilesListCubit>(context)
                                            .reset();
                                        BlocProvider.of<FilesListCubit>(context)
                                            .getFilesList(
                                                userId: widget.userId,
                                                context: context,
                                                order: (orderSelectedOption ==
                                                        1)
                                                    ? "name"
                                                    : (orderSelectedOption == 2)
                                                        ? "created_at"
                                                        : "",
                                                desc: (descSelectedOption == 1)
                                                    ? "desc"
                                                    : (descSelectedOption == 2)
                                                        ? "asc"
                                                        : "",
                                                name: searchController.text
                                                    .trim(),
                                                key: widget.groupKey);
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
                  BlocBuilder<FilesListCubit, FilesListState>(
                    builder: (context, state) {
                      if (state is FilesListLoaded ||
                          state is FilesListLoading) {
                        dlog("yeeeeeeeees");

                        if (state is FilesListLoaded) {
                          files = (state).filesList;

                          dprint(files);
                        }
                        return Column(
                          children: [
                            if (files.isNotEmpty)
                              RefreshIndicator(
                                onRefresh: () async {
                                  BlocProvider.of<FilesListCubit>(context)
                                      .reset();
                                  BlocProvider.of<FilesListCubit>(context)
                                      .getFilesList(
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
                                          name: searchController.text.trim(),
                                          key: widget.groupKey);
                                },
                                child: ListView.builder(
                                  primary: false,
                                  controller: listViewController,
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics(
                                      parent: BouncingScrollPhysics()),
                                  itemCount: files.length,
                                  itemBuilder: ((context, index) {
                                    bool isSelected = checkInCubit
                                        .selectFileKeys
                                        .containsKey(index);

                                    if (index < files.length) {
                                      return GestureDetector(
                                        onLongPress: () {
                                          checkInCubit.selectLongTab=true;
                                          checkInCubit
                                              .checkSelectedOrNotSelected(
                                                  selectFile: true,
                                                  index: index,
                                                  fileKey:
                                                      files[index].fileKey);
                                        },
                                        onTap: () {
                                          if(checkInCubit.selectLongTab) {
                                            if (checkInCubit
                                                  .selectFileKeys.length >
                                              index ) {
                                            if (checkInCubit
                                                .selectFileKeys[index]!.keys.first) {
                                              checkInCubit
                                                  .checkSelectedOrNotSelected(
                                                      selectFile: false,
                                                      index: index,
                                                      fileKey:
                                                          files[index].fileKey);
                                            } else if (!checkInCubit
                                                .selectFileKeys[index]!.keys.first) {
                                              checkInCubit
                                                  .checkSelectedOrNotSelected(
                                                      selectFile: true,
                                                      index: index,
                                                      fileKey:
                                                          files[index].fileKey);
                                            }
                                          } else {
                                            checkInCubit
                                                .checkSelectedOrNotSelected(
                                                    selectFile: true,
                                                    index: index,
                                                    fileKey:
                                                        files[index].fileKey);
                                          }
                                          }
                                        },
                                        child: Container(
                                          color: isSelected
                                              ? Colors.grey[300]
                                              : Colors.white,
                                          child: Row(
                                            children: [
                                              BlocBuilder<CheckInCubit,
                                                  CheckInState>(
                                                builder: (context, state) {
                                                  return Visibility(
                                                    visible: checkInCubit
                                                        .selectFileKeys[index]?.keys.first?? false,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          AppColors.darkGrey,
                                                      child: const Icon(
                                                          Icons.check),
                                                    ),
                                                  );
                                                },
                                              ),
                                              Expanded(
                                                  child: fileCard(
                                                      context, files[index])),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const Center(child: Loader());
                                    }
                                  }),
                                ),
                              ),
                            state is FilesListLoading
                                ? const Center(
                                    child: Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Loader(),
                                  ))
                                : TextButton.icon(
                                    onPressed: () {
                                      BlocProvider.of<FilesListCubit>(context)
                                          .getFilesList(
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
                                              name:
                                                  searchController.text.trim(),
                                              key: widget.groupKey);
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
                      if (state is FilesListError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                (state).filesListErrorMessage,
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
                                  BlocProvider.of<FilesListCubit>(context)
                                      .reset();
                                  BlocProvider.of<FilesListCubit>(context)
                                      .getFilesList(
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
                                          name: searchController.text.trim(),
                                          key: widget.groupKey);
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
      },
    );
  }
}
