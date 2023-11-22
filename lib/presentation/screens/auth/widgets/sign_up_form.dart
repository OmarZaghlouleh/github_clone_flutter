import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_clone_flutter/core/utils/extensions/space.dart';
import 'package:github_clone_flutter/cubit/auth/signup_confirm_password_visibility_cubit.dart';
import 'package:github_clone_flutter/cubit/auth/signup_password_visibility_cubit.dart';
import 'package:github_clone_flutter/presentation/common_widgets/custom_text_form_field.dart';
import 'package:github_clone_flutter/presentation/screens/auth/controllers/sign_up_controllers.dart';
import 'package:github_clone_flutter/presentation/style/app_sizes.dart';
import 'package:github_clone_flutter/presentation/style/app_text_style.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppSizes.signUpFormLeftPadding,
            ),
            child: Text(
              "Sign Up".toUpperCase(),
              style: AppTextStyle.headerTextStyle(),
            ),
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
          Form(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: AppSizes.signUpFormLeftPadding - 8, top: 40),
              child: Column(
                children: [
                  //Name
                  Row(
                    children: [
                      //First Name
                      Expanded(
                        child: CustomTextFormField(
                          controller: SignUpControllers.firstNameTextController,
                          label: "First name",
                          hint: "ex: Fadi",
                          textInputType: TextInputType.name,
                          icon: Icons.person_rounded,
                        ),
                      ),
                      //Last Name
                      Expanded(
                        child: CustomTextFormField(
                          controller: SignUpControllers.lastNameTextController,
                          label: "Last name",
                          hint: "ex: Za",
                          textInputType: TextInputType.name,
                        ),
                      ),
                    ],
                  ),
                  //accountname
                  CustomTextFormField(
                    controller: SignUpControllers.accountNameTextController,
                    label: "Account name",
                    hint: "example123",
                    icon: Icons.alternate_email_rounded,
                    textInputType: TextInputType.text,
                  ),
                  //Email
                  CustomTextFormField(
                    controller: SignUpControllers.emailTextController,
                    label: "Email",
                    hint: "example@gmail.com",
                    icon: Icons.email_rounded,
                    textInputType: TextInputType.emailAddress,
                  ),
                  //Password
                  BlocBuilder<SignupPasswordVisibilityCubit, bool>(
                    builder: (context, state) {
                      return CustomTextFormField(
                        controller: SignUpControllers.passwordTextController,
                        label: "Password",
                        icon: Icons.lock_rounded,
                        obsecure: state,
                        textInputType: TextInputType.visiblePassword,
                        onSuffixClick: () =>
                            BlocProvider.of<SignupPasswordVisibilityCubit>(
                                    context)
                                .toggleVisibility(),
                        suffixIcon:
                            state ? Icons.visibility_off : Icons.visibility,
                      );
                    },
                  ),
                  //Confirm Password
                  BlocBuilder<SignupConfirmPasswordVisibilityCubit, bool>(
                    builder: (context, state) {
                      return CustomTextFormField(
                        controller:
                            SignUpControllers.confirmPasswordTextController,
                        label: "Confirm your password",
                        icon: Icons.lock_rounded,
                        obsecure: state,
                        textInputType: TextInputType.visiblePassword,
                        onSuffixClick: () => BlocProvider.of<
                                SignupConfirmPasswordVisibilityCubit>(context)
                            .toggleVisibility(),
                        suffixIcon:
                            state ? Icons.visibility_off : Icons.visibility,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          10.space(),
          //Create Account Button
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: AppSizes.signUpFormLeftPadding, right: 8),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {},
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: Text(
                    "Create Account",
                    style: AppTextStyle.elevatedButtonTextStyle(),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
