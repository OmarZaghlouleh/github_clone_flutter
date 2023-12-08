import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/enums.dart';
import 'package:github_clone_flutter/cubit/files/all_files_cubit.dart';
import 'package:github_clone_flutter/cubit/files/filters/file_desc_cubit.dart';
import 'package:github_clone_flutter/cubit/files/filters/file_order_cubit.dart';

import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';

class FilesFilters extends StatelessWidget {
  const FilesFilters({super.key, required this.nameController});

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Order
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'Order By: ',
                style: AppTextStyle.getSmallBoldStyle(
                    color: AppColors.primaryColor),
              ),
              Wrap(
                children: Order.values
                    .getRange(0, 1)
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          BlocProvider.of<FileOrderCubit>(context)
                              .changeOrder(order: e);
                          BlocProvider.of<AllFilesCubit>(context).getAllFiles(
                              context: context,
                              name: nameController.text.trim(),
                              clear: true);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<FileOrderCubit, Order?>(
                            builder: (context, state) {
                              return Card(
                                color: state == e
                                    ? AppColors.primaryColor
                                    : AppColors.darkGrey,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    e.name.replaceAll("A", " A"),
                                    style: AppTextStyle.getSmallBoldStyle(
                                        color: AppColors.thirdColor),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
        // Desc
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'Order of items: ',
                style: AppTextStyle.getSmallBoldStyle(
                    color: AppColors.primaryColor),
              ),
              Wrap(
                children: Desc.values
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          BlocProvider.of<FileDescCubit>(context)
                              .changeDesc(desc: e);
                          BlocProvider.of<AllFilesCubit>(context).getAllFiles(
                              context: context,
                              name: nameController.text.trim(),
                              clear: true);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<FileDescCubit, Desc?>(
                            builder: (context, state) {
                              return Card(
                                color: state == e
                                    ? AppColors.primaryColor
                                    : AppColors.darkGrey,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${e.name}ending",
                                    style: AppTextStyle.getSmallBoldStyle(
                                        color: AppColors.thirdColor),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        )
      ],
    );
  }
}
