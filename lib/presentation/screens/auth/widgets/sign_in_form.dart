import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/core/utils/extensions/space.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/cubit/auth/sign_in/sign_in_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/sign_in/signin_password_visibility_cubit.dart';
import 'package:github_clone_flutter/presentation/common_widgets/custom_text_form_field.dart';
import 'package:github_clone_flutter/presentation/common_widgets/loader.dart';
import 'package:github_clone_flutter/presentation/screens/auth/controllers/sign_in_controllers.dart';
import 'package:github_clone_flutter/presentation/screens/auth/widgets/auth_section.dart';
import 'package:github_clone_flutter/presentation/screens/auth/widgets/fake_field.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_sizes.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key, this.isPortrait = false});

  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: AppSizes.signInFormLeftPadding, top: 10),
                child: Text(
                  "Sign In".toUpperCase(),
                  style: AppTextStyle.headerTextStyle(),
                ),
              ),
              10.space(),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 20,
                  child: VerticalDivider(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: () {
                      AuthSection.pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.linear);
                      SignInControllers.clearControllers();
                    },
                    child: Text(
                      "Create a new account".toUpperCase(),
                      style: AppTextStyle.authTextButtonStyle(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Form(
                    key: SignInControllers.signInFormKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: isPortrait
                              ? 0
                              : AppSizes.signInFormLeftPadding - 8,
                          top: 30),
                      child: Column(
                        children: [
                          //accountname
                          CustomTextFormField(
                            controller:
                                SignInControllers.accountNameTextController,
                            label: "Account name",
                            hint: "example123",
                            icon: Icons.alternate_email_rounded,
                            textInputType: TextInputType.text,
                            // maxLength: maxAccountNameLength,
                            validator: (_) {
                              return SignInControllers.validateAccountName();
                            },
                          ),

                          //Password
                          BlocBuilder<SignInPasswordVisibilityCubit, bool>(
                            builder: (context, state) {
                              return CustomTextFormField(
                                controller:
                                    SignInControllers.passwordTextController,
                                label: "Password",
                                icon: Icons.lock_rounded,
                                obsecure: state,
                                textInputType: TextInputType.visiblePassword,
                                onSuffixClick: () => BlocProvider.of<
                                        SignInPasswordVisibilityCubit>(context)
                                    .toggleVisibility(),
                                suffixIcon: state
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                validator: (_) {
                                  return SignInControllers.validatePassword();
                                },
                              );
                            },
                          ),

                          FakeField(
                            controller: SignInControllers.fakeFieldController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // 20.space(),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: isPortrait ? 0 : AppSizes.signInFormLeftPadding,
                      right: 8,
                      bottom: 8,
                    ),
                    child: Column(
                      children: [
                        const Divider(
                          color: AppColors.secondaryColor,
                          endIndent: 20,
                          indent: 20,
                        ),
                        BlocBuilder<SignInCubit, SignInState>(
                            builder: (context, state) {
                          if (state is SignInLoading) return const Loader();
                          return SizedBox(
                            width: isPortrait
                                ? 0.8.mqWdith(context)
                                : 0.28.mqWdith(context),
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (SignInControllers
                                            .signInFormKey.currentState !=
                                        null &&
                                    SignInControllers
                                        .signInFormKey.currentState!
                                        .validate()) {
                                  await BlocProvider.of<SignInCubit>(context)
                                      .signin(context: context);
                                } else if (SignInControllers
                                    .message.isNotEmpty) {
                                  showSnackBar(
                                      title: SignInControllers.message,
                                      context: context,
                                      error: true);
                                }
                              },
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                              child: Text(
                                "Sign In",
                                style: AppTextStyle.elevatedButtonTextStyle(),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                )
                //Create Account Button
              ],
            ),
          ),
        ],
      ),
    );
  }
}
