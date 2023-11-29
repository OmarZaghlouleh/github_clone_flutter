import 'package:flutter/material.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../domain/models/user_model.dart';
import '../../../style/app_colors.dart';
import '../../../style/border_radius.dart';

class BuildWidgetListWithPagination extends StatefulWidget {
  final PagingController<int, UserModel> pagingController;
  final List<bool> selectedStates;

  const BuildWidgetListWithPagination(
      {super.key,
      required this.pagingController,
      required this.selectedStates});

  @override
  State<BuildWidgetListWithPagination> createState() =>
      _BuildWidgetListWithPaginationState();
}

class _BuildWidgetListWithPaginationState
    extends State<BuildWidgetListWithPagination> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(
              BorderRadiusSizes.createGroupContainerRadius)),
      constraints: BoxConstraints(
        maxHeight: 0.3.mqHeight(context),
        maxWidth: 0.54.mqWdith(context),
      ),
      child: PagedListView<int, UserModel>(
        padding: EdgeInsets.only(
            left: 0.02.mqWdith(context),
            top: 0.01.mqHeight(context)),
        pagingController: widget.pagingController,
        builderDelegate: PagedChildBuilderDelegate<UserModel>(
          itemBuilder: (context, item, index) => Column(
            children: [
              CheckboxListTile(
                title: Text('${item.accountName}$index'),
                subtitle: Text(item.email),
                value: widget.selectedStates[index],
                onChanged: (bool? value) {
                  setState(() {
                    widget.selectedStates[index] = value!;
                  });
                },
              ),
              const Divider(
                color: AppColors.textFieldValueColor,
                // Customize the color
                thickness: 1.0, // Customize the thickness
              ),
            ],
          ),
        ),
      ),
    );
  }
}
