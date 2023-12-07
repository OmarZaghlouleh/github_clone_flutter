import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/enums.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/cubit/reports/filters/report_type_cubit.dart';
import 'package:github_clone_flutter/cubit/reports/reports_cubit.dart';
import 'package:github_clone_flutter/presentation/common_widgets/loader.dart';
import 'package:github_clone_flutter/presentation/screens/reports/widgets/filters.dart';
import 'package:github_clone_flutter/presentation/screens/reports/widgets/report_card_row.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';

class ReportsScreen extends StatelessWidget {
  ReportsScreen({super.key, required this.keyString});

  final ScrollController _scrollController = ScrollController();
  final String keyString;

  void init(BuildContext context) {
    if (!_scrollController.hasListeners) {
      BlocProvider.of<ReportsCubit>(context)
          .getReports(context: context, key: "", clear: true);
      dprint("Listener Added");
      _scrollController.addListener(() {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          BlocProvider.of<ReportsCubit>(context)
              .getReports(context: context, key: "");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reports',
          style: AppTextStyle.getMediumBoldStyle(color: AppColors.primaryColor),
        ),
      ),
      body: Column(
        children: [
          ExpansionTile(
            title: Text(
              'Filters',
              style:
                  AppTextStyle.getSmallBoldStyle(color: AppColors.primaryColor),
            ),
            children: [
              ReportsFilters(
                keyString: keyString,
              )
            ],
          ),
          BlocBuilder<ReportsCubit, ReportsState>(
            builder: (context, state) {
              if (state is ReportsLoading) {
                return const Expanded(child: Center(child: Loader()));
              }
              if (state is ReportsError ||
                  (state is ReportsLoaded && state.reports.isEmpty)) {
                return const Expanded(
                  child: Center(child: Text("There are no reports to show")),
                );
              } else {
                dprint("Here");
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await BlocProvider.of<ReportsCubit>(context)
                          .getReports(context: context, key: "", clear: true);
                    },
                    child: Scrollbar(
                      thumbVisibility: true,
                      trackVisibility: true,
                      controller: _scrollController,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        controller: _scrollController,
                        itemCount: (state as ReportsLoaded).reports.length,
                        itemBuilder: (contetx, index) => Card(
                          elevation: 5,
                          color: AppColors.primaryColor.withOpacity(0.5),
                          margin: const EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ReportRowCard(
                                    title: "Action",
                                    description: state.reports[index].action),
                                ReportRowCard(
                                    title: "At",
                                    description:
                                        state.reports[index].createdAt),
                                ReportRowCard(
                                    title: "By",
                                    description:
                                        state.reports[index].user.fullName),
                                ReportRowCard(
                                    title: "Importance",
                                    description: state.reports[index].importance
                                        .toString()),
                                ReportRowCard(
                                    title: "Info",
                                    description:
                                        state.reports[index].additionalInfo),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
