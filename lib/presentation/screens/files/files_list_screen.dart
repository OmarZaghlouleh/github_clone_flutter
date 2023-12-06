import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/cubit/files/files_list_cubit.dart';
import 'package:github_clone_flutter/presentation/screens/files/widgets/file_card.dart';
import '../../../core/utils/strings_manager.dart';
import '../../common_widgets/empty_widget.dart';
import '../../common_widgets/form_header.dart';
import '../../common_widgets/loader.dart';
import '../../style/app_colors.dart';
import '../../style/app_text_style.dart';
import '../auth/widgets/text_field_component.dart';

class FilesListScreen extends StatefulWidget {
  const FilesListScreen({super.key, required this.groupKey});
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

  List files = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Files",
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
                          BlocProvider.of<FilesListCubit>(context).reset();
                          BlocProvider.of<FilesListCubit>(context).getFilesList(
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
                  if (state is FilesListLoaded || state is FilesListLoading) {
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
                              BlocProvider.of<FilesListCubit>(context).reset();
                              BlocProvider.of<FilesListCubit>(context)
                                  .getFilesList(
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
                                if (index < files.length) {
                                  return fileCard(context, files[index]);
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
                              BlocProvider.of<FilesListCubit>(context).reset();
                              BlocProvider.of<FilesListCubit>(context)
                                  .getFilesList(
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
  }
}
