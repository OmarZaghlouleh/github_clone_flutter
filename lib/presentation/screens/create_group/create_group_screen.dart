import 'package:flutter/material.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/domain/models/user_model.dart';
import 'package:github_clone_flutter/presentation/common_widgets/custom_text_form_field.dart';
import 'package:github_clone_flutter/presentation/common_widgets/elevated_button_widget.dart';
import 'package:github_clone_flutter/presentation/screens/create_group/controllers/create_group_controllers.dart';
import 'package:github_clone_flutter/presentation/screens/create_group/widgets/build_widget_list_with_pagination.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/border_radius.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../style/app_text_style.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  bool checkValue = false;
  static const _pageSize = 4;

  final List<UserModel> newItems = const [
    UserModel(
        id: 1,
        role: 1,
        roleName: "admin",
        accountName: "user1",
        email: "user1@gmail.com",
        firstName: "user",
        lastName: "1",
        img: "",
        createdAt: ""),
    UserModel(
        id: 2,
        role: 2,
        roleName: "user2",
        accountName: "user2",
        email: "user2@gmail.com",
        firstName: "user",
        lastName: "2",
        img: "",
        createdAt: ""),
    UserModel(
        id: 3,
        role: 3,
        roleName: "user3",
        accountName: "user3",
        email: "user3@gmail.com",
        firstName: "user",
        lastName: "3",
        img: "",
        createdAt: ""),
    UserModel(
        id: 4,
        role: 4,
        roleName: "user4",
        accountName: "user4",
        email: "user4@gmail.com",
        firstName: "user",
        lastName: "4",
        img: "",
        createdAt: ""),
  ];
  List<bool> selectedStates = [];
  final PagingController<int, UserModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  int i = 0;

  Future<void> _fetchPage(int pageKey) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
        final newPage = newItems.sublist(pageKey, pageKey + _pageSize);

        if (newPage.isNotEmpty) {
          selectedStates.addAll(List.generate(newPage.length, (index) => false));
          _pagingController.appendPage(newPage, nextPageKey);
        } else {
          _pagingController.appendLastPage(newItems);
        }
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BuildBody(pagingController: _pagingController, selectedStates: selectedStates),
    );
  }
}

class BuildBody extends StatelessWidget {
  const BuildBody({
    super.key,
    required PagingController<int, UserModel> pagingController,
    required this.selectedStates,
  }) : _pagingController = pagingController;

  final PagingController<int, UserModel> _pagingController;
  final List<bool> selectedStates;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 0.95.mqWdith(context),
        height: 0.95.mqHeight(context),
        decoration: BoxDecoration(
            color: AppColors.thirdColor,
            borderRadius: BorderRadius.circular(
                BorderRadiusSizes.createGroupContainerRadius)),
        child: Form(
          key: CreateGroupControllers.createGroupFormKey,
          child: Padding(
            padding: EdgeInsets.only(
              top: 0.06.mqHeight(context),
              left: 0.2.mqWdith(context),
              right: 0.2.mqWdith(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 0.06.mqHeight(context)),
                  child: Text(
                    'Creat Group',
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
                Align(
                  alignment: Alignment.center,
                  child: BuildWidgetListWithPagination(
                    pagingController: _pagingController,
                    selectedStates: selectedStates,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      //  left: 0.05.mqWdith(context),
                      top: 0.06.mqHeight(context)),
                  child: SizedBox(
                    height: 0.08.mqHeight(context),
                    child: ElevatedButtonWidget(
                      onPressed: () {},
                      widget: const Text('create group'),
                      buttonStyle:
                          Theme.of(context).elevatedButtonTheme.style,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
