import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      this.minLines,
      this.maxLength,
      this.formatters,
      this.obsecure = false,
      this.validator,
      this.focusNode,
      this.textInputAction,
      this.onSubmit,
      required this.controller,
      this.maxLines = 1});
  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final String? hint;
  final bool obsecure;
  final IconData? suffixIcon;
  final TextInputType textInputType;
  final VoidCallback? onSuffixClick;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? formatters;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        focusNode: focusNode,
        inputFormatters: formatters,
        style: const TextStyle(
            color: AppColors.textFieldValueColor, fontWeight: FontWeight.w400),
        maxLength: maxLength,
        minLines: minLines,
        maxLines: maxLines,
        controller: controller,
        textInputAction: textInputAction ?? TextInputAction.next,
        onFieldSubmitted: onSubmit,
        obscureText: obsecure,
        obscuringCharacter: '*',
        validator: validator,
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          errorMaxLines: 5,
          errorStyle: const TextStyle(color: AppColors.errorColor),
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
            borderSide: const BorderSide(color: AppColors.primaryColor),
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
          enabledBorder: OutlineInputBorder(
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
