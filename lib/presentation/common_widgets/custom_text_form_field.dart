import 'package:flutter/material.dart';
import 'package:github_clone_flutter/presentation/style/app_colors.dart';
import 'package:github_clone_flutter/presentation/style/border_radius.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.label,
      required this.textInputType,
      this.onSuffixClick,
      this.icon,
      this.suffixIcon,
      this.hint,
      this.obsecure = false,
      required this.controller});
  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final String? hint;
  final bool obsecure;
  final IconData? suffixIcon;
  final TextInputType textInputType;
  final VoidCallback? onSuffixClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        obscureText: obsecure,
        obscuringCharacter: '*',
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          label: FittedBox(
            child: Text(
              label,
              style: const TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.w600),
            ),
          ),
          prefixIcon: icon == null ? null : Icon(icon),
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    onPressed: onSuffixClick,
                    icon: Icon(
                      suffixIcon,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                )
              : null,
          floatingLabelStyle: const TextStyle(
              color: AppColors.primaryColor, fontWeight: FontWeight.w500),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              BorderRadiusSizes.textFormFieldRadius,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(
              BorderRadiusSizes.textFormFieldRadius,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.errorColor),
            borderRadius: BorderRadius.circular(
              BorderRadiusSizes.textFormFieldRadius,
            ),
          ),
        ),
      ),
    );
  }
}
