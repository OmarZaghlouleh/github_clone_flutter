import 'package:flutter/material.dart';
import 'package:github_clone_flutter/presentation/screens/auth/widgets/sign_in_form.dart';
import 'package:github_clone_flutter/presentation/screens/auth/widgets/sign_up_form.dart';

class AuthSection extends StatelessWidget {
  const AuthSection({super.key, required this.isPortrait});

  static final pageController = PageController();
  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          SignInForm(isPortrait: isPortrait),
          SignUpForm(isPortrait: isPortrait),
        ],
      ),
    );
  }
}
