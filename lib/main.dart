import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/global.dart';

import 'package:github_clone_flutter/core/utils/service_locator_di.dart';
import 'package:github_clone_flutter/cubit/add_files_to_group/add_files_to_group_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/cubit/logout_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/sign_in/sign_in_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/sign_in/signin_password_visibility_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/sign_up/signup_confirm_password_visibility_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/sign_up/signup_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/sign_up/signup_password_visibility_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/sign_up/signup_profile_image_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/sign_up/signup_profile_image_hover_cubit.dart';
import 'package:github_clone_flutter/cubit/check_in/check_in_cubit.dart';
import 'package:github_clone_flutter/cubit/check_out/check_out_cubit.dart';
import 'package:github_clone_flutter/cubit/create_group/create_group_cubit.dart';
import 'package:github_clone_flutter/cubit/files/all_files_cubit.dart';
import 'package:github_clone_flutter/cubit/files/files_loading_more_cubit.dart';
import 'package:github_clone_flutter/cubit/files/filters/file_desc_cubit.dart';
import 'package:github_clone_flutter/cubit/files/filters/file_order_cubit.dart';
import 'package:github_clone_flutter/cubit/get_list_users/get_list_users_cubit.dart';
import 'package:github_clone_flutter/cubit/group/all_groups_cubit.dart';
import 'package:github_clone_flutter/cubit/group/filters/group_desc_cubit.dart';
import 'package:github_clone_flutter/cubit/group/filters/group_order_cubit.dart';
import 'package:github_clone_flutter/cubit/group/group_contributers_cubit.dart';
import 'package:github_clone_flutter/cubit/group/group_loading_more_cubit.dart';
import 'package:github_clone_flutter/cubit/group/my_groups_cubit.dart';
import 'package:github_clone_flutter/cubit/profile/profile_cubit.dart';
import 'package:github_clone_flutter/cubit/replace_file_cubit/replace_file_cubit.dart';
import 'package:github_clone_flutter/cubit/reports/filters/report_action_cubit.dart';
import 'package:github_clone_flutter/cubit/reports/filters/report_desc_cubit.dart';
import 'package:github_clone_flutter/cubit/reports/filters/report_order_cubit.dart';
import 'package:github_clone_flutter/cubit/reports/filters/report_type_cubit.dart';
import 'package:github_clone_flutter/cubit/reports/reports_cubit.dart';
import 'package:github_clone_flutter/cubit/reports/reports_loading_more_cubit.dart';
import 'package:github_clone_flutter/cubit/update_group_cubit/update_group_cubit.dart';
import 'package:github_clone_flutter/cubit/users/users_cubit.dart';
import 'package:github_clone_flutter/cubit/users/users_loading_more_cubit.dart';
import 'package:github_clone_flutter/data/data_resource/local_resource/shared_preferences.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:github_clone_flutter/presentation/screens/splash_screen.dart';
import 'package:github_clone_flutter/presentation/style/themes/app_theme.dart';

import 'cubit/files/files_list_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // checkInternetApp();
  BaseApiClient();

  setUp();
  await LocalResource.initLocalResource();
  runApp(const GithubCloneApp());
}

class GithubCloneApp extends StatelessWidget {
  const GithubCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignupPasswordVisibilityCubit()),
        BlocProvider(
            create: (context) => SignupConfirmPasswordVisibilityCubit()),
        BlocProvider(create: (context) => SignupProfileImageCubit()),
        BlocProvider(create: (context) => SignupProfileImageHoverCubit()),
        BlocProvider(create: (context) => SignupCubit()),
        BlocProvider(create: (context) => SignInPasswordVisibilityCubit()),
        BlocProvider(create: (context) => SignInCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => CreateGroupCubit()),
        BlocProvider(create: (context) => getIt<GetListUsersCubit>()),
        BlocProvider(create: (context) => UpdateGroupCubit()),
        BlocProvider(create: (context) => MyGroupsCubit()),
        BlocProvider(create: (context) => AddFilesToGroupCubit()),
        BlocProvider(create: (context) => FilesListCubit()),
        BlocProvider(create: (context) => ReportsCubit()),
        BlocProvider(create: (context) => ReportTypeCubit()),
        BlocProvider(create: (context) => ReportOrderCubit()),
        BlocProvider(create: (context) => ReportDescCubit()),
        BlocProvider(create: (context) => ReportActionCubit()),
        BlocProvider(create: (context) => AllGroupsCubit()),
        BlocProvider(create: (context) => GroupOrderCubit()),
        BlocProvider(create: (context) => GroupDescCubit()),
        BlocProvider(create: (context) => AllFilesCubit()),
        BlocProvider(create: (context) => FileOrderCubit()),
        BlocProvider(create: (context) => FileDescCubit()),
        BlocProvider(create: (context) => GroupContributersCubit()),
        BlocProvider(
          create: (context) => ReplaceFileCubit(),
        ),
        BlocProvider(create: (context) => CheckInCubit()),
        BlocProvider(create: (context) => CheckOutCubit()),
        BlocProvider(create: (context) => GroupLoadingMoreCubit()),
        BlocProvider(create: (context) => FilesLoadingMoreCubit()),
        BlocProvider(create: (context) => ReportsLoadingMoreCubit()),
        BlocProvider(create: (context) => LogoutCubit()),
        BlocProvider(create: (context) => UsersCubit()),
        BlocProvider(create: (context) => UsersLoadingMoreCubit()),
      ],
      child: MaterialApp(
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.unknown,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.invertedStylus,
          },
        ),
        title: 'Github Clone',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: appTheme(),
        home:
            //const HomeScreen(),
            // const SignUpScreen(),
            // const UpdateGroupScreen(),
            const SplashScreen(),
      ),
    );
  }
}
