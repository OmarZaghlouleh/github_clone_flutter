import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/cubit/update_group_cubit/update_group_cubit.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/repository/Update_group_repo.dart';
import 'package:github_clone_flutter/domain/models/params/update_group_params.dart';
import 'package:github_clone_flutter/domain/models/user_model.dart';
import 'package:github_clone_flutter/presentation/common_widgets/custom_text_form_field.dart';
import 'package:github_clone_flutter/presentation/common_widgets/elevated_button_widget.dart';
import 'package:github_clone_flutter/presentation/common_widgets/show_toast_widget.dart';
import 'package:github_clone_flutter/presentation/screens/group/controllers/create_group_controllers.dart';
import 'package:github_clone_flutter/presentation/screens/group/widgets/build_widget_list_with_pagination.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/border_radius.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/utils/service_locator_di.dart';
import '../../../cubit/get_list_users/get_list_users_cubit.dart';
import '../../../cubit/get_list_users/get_list_users_state.dart';
import '../../../cubit/update_group_cubit/update_group_state.dart';
import '../../common_widgets/loader.dart';
import '../../style/app_text_style.dart';

class UpdateGroupScreen extends StatefulWidget {
  const UpdateGroupScreen({super.key});

  @override
  State<UpdateGroupScreen> createState() => _UpdateGroupScreenState();
}

class _UpdateGroupScreenState extends State<UpdateGroupScreen> {
  List<UserModel> listUsers = [];

  final PagingController<int, UserModel> _pagingControllerForUsersAddedToGroup =
      PagingController(firstPageKey: 1);
  final PagingController<int, UserModel>
      _pagingControllerForUsersDeletedFromGroup =
      PagingController(firstPageKey: 1);
  static final GetListUsersCubit getListUsersCubit = getIt<GetListUsersCubit>();

  @override
  void initState() {
    _pagingControllerForUsersAddedToGroup.addPageRequestListener((pageKey) {
      _fetchPage(
          pageKey: pageKey,
          pagingController: _pagingControllerForUsersAddedToGroup);
    });
    _pagingControllerForUsersDeletedFromGroup.addPageRequestListener((pageKey) {
      _fetchPage(
          pageKey: pageKey,
          pagingController: _pagingControllerForUsersDeletedFromGroup);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingControllerForUsersDeletedFromGroup.dispose();
    _pagingControllerForUsersDeletedFromGroup.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(
      {required int pageKey,
      required PagingController pagingController}) async {
    try {
      await getListUsersCubit.getListUsers(pageKey: pageKey);
      listUsers.clear();

      if (getListUsersCubit.state is GetListUsersStateLoaded) {
        listUsers.addAll((getListUsersCubit.state as GetListUsersStateLoaded)
            .usersModel
            .items);
      }
      final isLastPage = listUsers.length < GetListUsersCubit.perPage!;
      if (isLastPage) {
        pagingController.appendLastPage(listUsers);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(listUsers, nextPageKey);
      }
    } catch (e) {
      if (kDebugMode) {
        print("error --> $e");
      }
      pagingController.error = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BuildBody(
        pagingControllerForUsersAddedToGroup:
            _pagingControllerForUsersAddedToGroup,
        pagingControllerForUsersDeletedFromGroup:
            _pagingControllerForUsersDeletedFromGroup,
      ),
    );
  }
}

class BuildBody extends StatelessWidget {
  final PagingController<int, UserModel> pagingControllerForUsersAddedToGroup;

  final PagingController<int, UserModel>
      pagingControllerForUsersDeletedFromGroup;

  const BuildBody({
    super.key,
    required this.pagingControllerForUsersAddedToGroup,
    required this.pagingControllerForUsersDeletedFromGroup,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          width: 0.95 * constraints.maxWidth,
          height: 0.95 * constraints.maxHeight,
          decoration: BoxDecoration(
              color: AppColors.thirdColor,
              borderRadius: BorderRadius.circular(
                  BorderRadiusSizes.createGroupContainerRadius)),
          child: Form(
            key: CreateGroupControllers.createGroupFormKey,
            child: Padding(
              padding: EdgeInsets.only(
                top: 0.02.mqHeight(context),
                left: 0.2.mqWdith(context),
                right: 0.2.mqWdith(context),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 0.02.mqHeight(context),
                      ),
                      child: Text(
                        'Update Group',
                        style: AppTextStyle.headerTextStyle(),
                      ),
                    ),
                    CustomTextFormField(
                        label: 'Name Group',
                        textInputType: TextInputType.text,
                        controller:
                            CreateGroupControllers.nameGroupTextController),
                    SizedBox(
                      height: 0.02.mqHeight(context),
                    ),
                    CustomTextFormField(
                        maxLines: null,
                        minLines: 2,
                        label: 'Description Group',
                        textInputType: TextInputType.text,
                        controller: CreateGroupControllers
                            .descriptionGroupTextController),
                    SizedBox(
                      height: 0.02.mqHeight(context),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.01.mqWdith(context)),
                      child: const Text(
                        'Add users to the group :',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 0.02.mqHeight(context),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: BuildWidgetListWithPagination(
                        pagingController: pagingControllerForUsersAddedToGroup,
                      ),
                    ),
                    SizedBox(
                      height: 0.02.mqHeight(context),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.01.mqWdith(context)),
                      child: const Text(
                        'Delete users from the group :',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 0.02.mqHeight(context),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: BuildWidgetListWithPagination(
                        delete: true,
                        pagingController:
                            pagingControllerForUsersDeletedFromGroup,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 0.06.mqHeight(context),bottom: 0.02.mqHeight(context),),

                      child: SizedBox(
                        height: 0.08.mqHeight(context),
                        child: BlocConsumer<UpdateGroupCubit, UpdateGroupState>(
                          listener: (context, state) {
                            if (state is UpdateGroupStateLoaded) {
                              showToastWidget(
                                  'The group has been modified successfully');
                            }

                          },
                          builder:(context,state)
                          {
                            if (state is UpdateGroupStateLoading) return const Loader();
                                return  ElevatedButtonWidget(
                                    onPressed: () async {
                                      List<int> listUsersSelectedToJoinGroup =
                                          [];
                                      List<int> listUsersDeleted = [];
                                      GetListUsersCubit
                                          .listUsersDeletedFromGroup
                                          .forEach((key, value) {
                                        if (value) {
                                          listUsersDeleted.add(key.id);
                                        }
                                      });
                                      GetListUsersCubit
                                          .listUsersWithVariableBoolean
                                          .forEach((key, value) {
                                        if (value) {
                                          listUsersSelectedToJoinGroup
                                              .add(key.id);
                                        }
                                      });
                                      await BlocProvider.of<
                                              UpdateGroupCubit>(context)
                                          .updateGroup(
                                              updateGroupObject: UpdateGroupParams(
                                                  name: CreateGroupControllers
                                                      .nameGroupTextController
                                                      .text,
                                                  desc: CreateGroupControllers
                                                      .descriptionGroupTextController
                                                      .text,
                                                  listUsers:
                                                      listUsersSelectedToJoinGroup,
                                                  deletedUsersList:
                                                      listUsersDeleted),
                                              context: context);
                                    },
                                    widget: const Text('update group'),
                                    buttonStyle: Theme.of(context)
                                        .elevatedButtonTheme
                                        .style,
                                  );
                                }),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
