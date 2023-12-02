import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/cubit/create_group/create_group_cubit.dart';
import 'package:github_clone_flutter/cubit/create_group/create_group_state.dart';
import 'package:github_clone_flutter/cubit/get_list_users/get_list_users_cubit.dart';
import 'package:github_clone_flutter/cubit/get_list_users/get_list_users_state.dart';
import 'package:github_clone_flutter/domain/models/params/create_group_params.dart';
import 'package:github_clone_flutter/domain/models/user_model.dart';
import 'package:github_clone_flutter/presentation/common_widgets/custom_text_form_field.dart';
import 'package:github_clone_flutter/presentation/common_widgets/elevated_button_widget.dart';
import 'package:github_clone_flutter/presentation/screens/group/controllers/create_group_controllers.dart';
import 'package:github_clone_flutter/presentation/screens/group/widgets/build_widget_list_with_pagination.dart';
import 'package:github_clone_flutter/presentation/screens/home/home_screen.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/border_radius.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/service_locator_di.dart';
import '../../common_widgets/loader.dart';
import '../../common_widgets/show_toast_widget.dart';
import '../../style/app_text_style.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  List<UserModel> listUsers = [];

  final PagingController<int, UserModel> _pagingController =
      PagingController(firstPageKey: 1);
  static final GetListUsersCubit getListUsersCubit = getIt<GetListUsersCubit>();

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
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
        _pagingController.appendLastPage(listUsers);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(listUsers, nextPageKey);
      }
    } catch (e) {
      if (kDebugMode) {
        print("error --> $e");
      }
      _pagingController.error = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BuildBody(
        pagingController: _pagingController,
      ),
    );
  }
}

class BuildBody extends StatelessWidget {
  const BuildBody({
    super.key,
    required this.pagingController,
  });

  final PagingController<int, UserModel> pagingController;

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
              BorderRadiusSizes.createGroupContainerRadius,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 0.02.mqHeight(context),
              left: 0.2.mqWdith(context),
              right: 0.2.mqWdith(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 0.02.mqHeight(context),
                     ),
                  child: Text(
                    'Create Group',
                    style: AppTextStyle.headerTextStyle(),
                  ),
                ),
                CustomTextFormField(
                    label: 'Name Group',
                    textInputType: TextInputType.text,
                    controller: CreateGroupControllers.nameGroupTextController),
                SizedBox(
                  height: 0.02.mqHeight(context),
                ),
                CustomTextFormField(
                    maxLines: null,
                    minLines: 2,
                    label: 'Description Group',
                    textInputType: TextInputType.text,
                    controller:
                        CreateGroupControllers.descriptionGroupTextController),
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
                BuildWidgetListWithPagination(
                  pagingController: pagingController,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 0.06.mqHeight(context),
                  ),
                  child: SizedBox(
                    height: 0.08.mqHeight(context),
                    child: BlocConsumer<CreateGroupCubit, CreateGroupState>(
                      listener: (context, state) {
                        if (state is CreateGroupStateLoaded) {
                          showToastWidget(
                              'A group has been created successfully');
                        }
                      },
                      builder: (context, state) {
                        if (state is CreateGroupStateLoading) return const Loader();
                        return ElevatedButtonWidget(
                          onPressed: ()async {
                            List<int> listUsersSelectedToJoinGroup = [];
                            GetListUsersCubit.listUsersWithVariableBoolean
                                .forEach((key, value) {
                              if (value) {
                                listUsersSelectedToJoinGroup.add(key.id);
                              }
                            });

                          await  BlocProvider.of<CreateGroupCubit>(context).createGroup(
                                createGroupParams: CreateGroupParams(
                                    name: CreateGroupControllers
                                        .nameGroupTextController.text,
                                    desc: CreateGroupControllers
                                        .descriptionGroupTextController.text,
                                    usersList: listUsersSelectedToJoinGroup),
                                context: context);
                          },
                          widget: const Text('create group'),
                          buttonStyle:
                              Theme.of(context).elevatedButtonTheme.style,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
