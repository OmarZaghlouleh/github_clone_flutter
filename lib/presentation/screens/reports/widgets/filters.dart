import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/enums.dart';
import 'package:github_clone_flutter/cubit/reports/filters/report_action_cubit.dart';
import 'package:github_clone_flutter/cubit/reports/filters/report_desc_cubit.dart';
import 'package:github_clone_flutter/cubit/reports/filters/report_order_cubit.dart';
import 'package:github_clone_flutter/cubit/reports/filters/report_type_cubit.dart';
import 'package:github_clone_flutter/cubit/reports/reports_cubit.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';

class ReportsFilters extends StatelessWidget {
  const ReportsFilters({super.key, required this.keyString});

  final String keyString;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (keyString.isEmpty)
          // Type
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Report Type: ',
                  style: AppTextStyle.getSmallBoldStyle(
                      color: AppColors.primaryColor),
                ),
                Wrap(
                  children: Report.values
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            BlocProvider.of<ReportTypeCubit>(context)
                                .toggleType();
                            BlocProvider.of<ReportsCubit>(context).getReports(
                                context: context, key: keyString, clear: true);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BlocBuilder<ReportTypeCubit, Report>(
                              builder: (context, state) {
                                return Card(
                                  color: state == e
                                      ? AppColors.primaryColor
                                      : AppColors.darkGrey,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      e.name,
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
        // Action
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'Action: ',
                style: AppTextStyle.getSmallBoldStyle(
                    color: AppColors.primaryColor),
              ),
              Wrap(
                children: ActionType.values
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          BlocProvider.of<ReportActionCubit>(context)
                              .changeAction(actionType: e);
                          BlocProvider.of<ReportsCubit>(context).getReports(
                              context: context, key: keyString, clear: true);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<ReportActionCubit, ActionType?>(
                            builder: (context, state) {
                              return Card(
                                color: state == e
                                    ? AppColors.primaryColor
                                    : AppColors.darkGrey,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    e.name,
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
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          BlocProvider.of<ReportOrderCubit>(context)
                              .changeOrder(order: e);
                          BlocProvider.of<ReportsCubit>(context).getReports(
                              context: context, key: keyString, clear: true);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<ReportOrderCubit, Order?>(
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
                          BlocProvider.of<ReportDescCubit>(context)
                              .changeDesc(desc: e);
                          BlocProvider.of<ReportsCubit>(context).getReports(
                              context: context, key: keyString, clear: true);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<ReportDescCubit, Desc?>(
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
