import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_clone_flutter/core/utils/global.dart';
import 'package:github_clone_flutter/data/check_internet/check_internet_handler.dart';
import 'package:github_clone_flutter/data/data_resource/remote_resource/api_handler/base_api_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  PushNotificationService().setupInteractedMessage();
  checkInternetApp();
  BaseApiClient();

  // await DataStore.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('final navigatorKey ${navigatorKey.currentContext}');
    return MultiBlocProvider(
      providers: [],
      child: ScreenUtilInit(
          designSize: const Size(430, 932),
          minTextAdapt: true,
          splitScreenMode: false,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              //home: ResetPasswordScreen(),
            );
          }),
    );
  }
}
