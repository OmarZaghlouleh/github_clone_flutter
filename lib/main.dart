import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/global.dart';
import 'package:github_clone_flutter/cubit/auth/signup_confirm_password_visibility_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/signup_password_visibility_cubit.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:github_clone_flutter/presentation/screens/auth/sign_up_screen.dart';
import 'package:github_clone_flutter/presentation/style/themes/app_theme.dart';

import 'presentation/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // checkInternetApp();
  BaseApiClient();
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
      ],
      child: MaterialApp(
        title: 'Github Clone',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: appTheme(),
        home: const HomeScreen(),
        // const SignUpScreen(),
      ),
    );
  }
}
