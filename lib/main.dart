import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/global.dart';
import 'package:github_clone_flutter/core/utils/service_locator_di.dart';
import 'package:github_clone_flutter/cubit/auth/sign_in/sign_in_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/sign_in/signin_password_visibility_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/sign_up/signup_confirm_password_visibility_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/sign_up/signup_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/sign_up/signup_password_visibility_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/sign_up/signup_profile_image_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/sign_up/signup_profile_image_hover_cubit.dart';
import 'package:github_clone_flutter/data/data_resource/local_resource/shared_preferences.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:github_clone_flutter/presentation/screens/auth/auth_screen.dart';
import 'package:github_clone_flutter/presentation/style/themes/app_theme.dart';

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
      ],
      child: MaterialApp(
        title: 'Github Clone',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: appTheme(),
        home: const AuthScreen(),
      ),
    );
  }
}
