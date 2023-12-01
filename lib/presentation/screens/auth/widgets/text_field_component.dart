import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../style/app_colors.dart';
import '../../../style/app_text_style.dart';
import '../../../style/text_field_decoration.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent({
    super.key,
    required this.controller,
    required this.title,
    required this.validate,
    required this.formatters,
    required this.textInputType,
    this.onFieldSubmitted,
    this.maxLength,
    this.minLines,
    this.autoFocus,
    this.textInputAction,
  });
  final TextEditingController controller;
  final String title;
  final Function validate;
  final List<TextInputFormatter> formatters;
  final TextInputType textInputType;
  final int? maxLength;
  final int? minLines;
  final bool? autoFocus;
  final TextInputAction? textInputAction;
  final Function? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        autofocus: autoFocus ?? false,
        minLines: minLines,
        maxLines: minLines,
        onFieldSubmitted: (value) {
          if (onFieldSubmitted != null) onFieldSubmitted!();
        },
        controller: controller,
        onChanged: (value) {},
        onEditingComplete: () {},
        validator: (value) {
          return validate();
        },
        keyboardType: textInputType,
        maxLength: maxLength,
        decoration: inputDecorationTextFormField(title, context),
        inputFormatters: formatters,
        style: AppTextStyle.getSmallBoldStyle(
          color: AppColors.secondaryColor,
        ),
        textInputAction: textInputAction ?? TextInputAction.next,
      ),
    );
  }
}
