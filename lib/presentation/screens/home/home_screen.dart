import 'dart:async';
import 'package:flutter/material.dart';
import 'package:github_clone_flutter/core/utils/constants.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/presentation/screens/groups/my_groups_screen.dart';
import '../../../core/utils/global.dart';
import '../../style/app_colors.dart';
import '../profile/profile_screen.dart';
import 'widgets/home_drawer_component.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Timer.run(() => scaffoldkey.currentState?.openDrawer());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      drawerScrimColor: AppColors.thirdColor.withOpacity(0),
      drawer: (1.mqWdith(context) < bigScreen) ? const HomeDrawer() : null,
      body: Row(
        children: [
          if (1.mqWdith(context) >= bigScreen) const HomeDrawer(),
          // const Expanded(child: MyGroupsScreen()),

          const Expanded(child: ProfileScreen(profileId: -1)),
        ],
      ),
    );
  }
}
