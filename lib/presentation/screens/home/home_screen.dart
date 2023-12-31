import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/presentation/screens/home/widgets/home_drawer_component.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/global.dart';
import '../../../cubit/profile/profile_cubit.dart';
import '../groups/my_groups_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<ProfileCubit>(context).getProfile(context: context, id: -1);
    // Timer.run(() => scaffoldkey.currentState?.openDrawer());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      drawerScrimColor: AppColors.thirdColor.withOpacity(0),
      drawer: (1.mqWidth(context) < bigScreen) ? const HomeDrawer() : null,
      body: Row(
        children: [
          if (1.mqWidth(context) >= bigScreen) const HomeDrawer(),
          // const Expanded(child: MyGroupsScreen()),
          // ignore: prefer_const_constructors
          Expanded(child: ProfileScreen(profileId: -1)),
        ],
      ),
    );
  }
}
