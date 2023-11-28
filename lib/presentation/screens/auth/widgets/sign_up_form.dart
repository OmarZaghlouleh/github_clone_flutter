import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/constants.dart';
import 'package:github_clone_flutter/core/utils/extensions/media_query.dart';
import 'package:github_clone_flutter/core/utils/extensions/space.dart';
import 'package:github_clone_flutter/core/utils/utils_functions.dart';
import 'package:github_clone_flutter/cubit/auth/sign_up/signup_confirm_password_visibility_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/sign_up/signup_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/sign_up/signup_password_visibility_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/sign_up/signup_profile_image_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/sign_up/signup_profile_image_hover_cubit.dart';
import 'package:github_clone_flutter/presentation/common_widgets/custom_text_form_field.dart';
import 'package:github_clone_flutter/presentation/common_widgets/loader.dart';
import 'package:github_clone_flutter/presentation/screens/auth/controllers/sign_up_controllers.dart';
import 'package:github_clone_flutter/presentation/screens/auth/widgets/auth_section.dart';
import 'package:github_clone_flutter/presentation/screens/auth/widgets/fake_field.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/app_sizes.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key, this.isPortrait = false});

  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: AppSizes.signUpFormLeftPadding, top: 10),
                    child: Text(
                      "Sign Up".toUpperCase(),
                      style: AppTextStyle.headerTextStyle(),
                    ),
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
                      onHover: null,
                      onPressed: () {
                        AuthSection.pageController.animateToPage(0,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.linear);
                        SignUpControllers.clearControllers();
                        BlocProvider.of<SignupProfileImageCubit>(context)
                            .reset();
                      },
                      child: Text(
                        "Sign In instead".toUpperCase(),
                        style: AppTextStyle.authTextButtonStyle(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 3,
                left: AppSizes.signUpFormLeftPadding + 3,
              ),
              child: Text(
                "Welcome to the Github clone \nRegister as a member to experience."
                    .toUpperCase(),
                style: AppTextStyle.descriptionStyle(),
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Form(
                    key: SignUpControllers.signUpFormKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: isPortrait
                              ? 0
                              : AppSizes.signUpFormLeftPadding - 8,
                          top: 30),
                      child: Column(
                        children: [
                          // Image
                          BlocBuilder<SignupProfileImageCubit, MemoryImage?>(
                            builder: (context, state) {
                              return InkWell(
                                onTap: () async {
                                  BlocProvider.of<SignupProfileImageHoverCubit>(
                                          context)
                                      .setHover(false);
                                  await BlocProvider.of<
                                          SignupProfileImageCubit>(context)
                                      .pickProfileImage();
                                },
                                onHover: (hover) {
                                  BlocProvider.of<SignupProfileImageHoverCubit>(
                                          context)
                                      .toggleHover(hover);
                                },
                                child: CircleAvatar(
                                  radius: 75,
                                  backgroundImage: state,
                                  child: BlocBuilder<
                                      SignupProfileImageHoverCubit, bool>(
                                    builder: (context, hover) {
                                      if (hover == false && state != null) {
                                        return const SizedBox.shrink();
                                      }
                                      return CircleAvatar(
                                        radius: 20,
                                        backgroundColor: state == null
                                            ? Colors.transparent
                                            : AppColors.primaryColor,
                                        child: Icon(
                                          Icons.add_a_photo_outlined,
                                          color: state == null
                                              ? AppColors.primaryColor
                                              : AppColors.thirdColor,
                                          size: 20,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          10.space(),
                          //Name
                          Row(
                            children: [
                              //First Name
                              Expanded(
                                child: CustomTextFormField(
                                  controller:
                                      SignUpControllers.firstNameTextController,
                                  label: "First name",
                                  hint: "ex: Fadi",
                                  textInputType: TextInputType.name,
                                  icon: Icons.person_rounded,
                                  maxLength: maxNameLength,
                                  validator: (_) {
                                    return SignUpControllers
                                        .validateFirstName();
                                  },
                                ),
                              ),
                              //Last Name
                              Expanded(
                                child: CustomTextFormField(
                                  controller:
                                      SignUpControllers.lastNameTextController,
                                  label: "Last name",
                                  hint: "ex: Za",
                                  textInputType: TextInputType.name,
                                  maxLength: maxNameLength,
                                  validator: (_) {
                                    return SignUpControllers.validateLastName();
                                  },
                                ),
                              ),
                            ],
                          ),
                          //accountname
                          CustomTextFormField(
                            controller:
                                SignUpControllers.accountNameTextController,
                            label: "Account name",
                            hint: "example123",
                            icon: Icons.alternate_email_rounded,
                            textInputType: TextInputType.text,
                            maxLength: maxAccountNameLength,
                            validator: (_) {
                              return SignUpControllers.validateAccountName();
                            },
                          ),
                          //Email
                          CustomTextFormField(
                            controller: SignUpControllers.emailTextController,
                            label: "Email",
                            hint: "example@gmail.com",
                            icon: Icons.email_rounded,
                            textInputType: TextInputType.emailAddress,
                            validator: (_) {
                              return SignUpControllers.validateEmail();
                            },
                          ),
                          //Password
                          BlocBuilder<SignupPasswordVisibilityCubit, bool>(
                            builder: (context, state) {
                              return CustomTextFormField(
                                controller:
                                    SignUpControllers.passwordTextController,
                                label: "Password",
                                icon: Icons.lock_rounded,
                                obsecure: state,
                                textInputType: TextInputType.visiblePassword,
                                onSuffixClick: () => BlocProvider.of<
                                        SignupPasswordVisibilityCubit>(context)
                                    .toggleVisibility(),
                                suffixIcon: state
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                validator: (_) {
                                  return SignUpControllers.validatePassword();
                                },
                              );
                            },
                          ),
                          //Confirm Password
                          BlocBuilder<SignupConfirmPasswordVisibilityCubit,
                              bool>(
                            builder: (context, state) {
                              return CustomTextFormField(
                                controller: SignUpControllers
                                    .confirmPasswordTextController,
                                label: "Confirm your password",
                                icon: Icons.lock_rounded,
                                obsecure: state,
                                textInputType: TextInputType.visiblePassword,
                                onSuffixClick: () => BlocProvider.of<
                                            SignupConfirmPasswordVisibilityCubit>(
                                        context)
                                    .toggleVisibility(),
                                // focusNode:
                                //     SignUpControllers.confirmPasswordFocusNode,
                                suffixIcon: state
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                validator: (_) {
                                  return SignUpControllers
                                      .validateConfirmPassword();
                                },
                              );
                            },
                          ),
                          FakeField(
                            controller: SignUpControllers.fakeFieldController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                20.space(),
                //Create Account Button
              ],
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(
              left: isPortrait ? 0 : AppSizes.signUpFormLeftPadding,
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
                BlocBuilder<SignupCubit, SignupState>(
                    builder: (context, state) {
                  if (state is SignupLoading) return const Loader();
                  return SizedBox(
                    width: isPortrait
                        ? 0.9.mqWdith(context)
                        : 0.28.mqWdith(context),
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (SignUpControllers.signUpFormKey.currentState !=
                                null &&
                            SignUpControllers.signUpFormKey.currentState!
                                .validate()) {
                          await BlocProvider.of<SignupCubit>(context)
                              .signup(context: context);
                        } else if (SignUpControllers.message.isNotEmpty) {
                          showSnackBar(
                              title: SignUpControllers.message,
                              context: context,
                              error: true);
                        }
                      },
                      style: Theme.of(context).elevatedButtonTheme.style,
                      child: Text(
                        "Create Account",
                        style: AppTextStyle.elevatedButtonTextStyle(),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        )
      ],
    );
  }
}
