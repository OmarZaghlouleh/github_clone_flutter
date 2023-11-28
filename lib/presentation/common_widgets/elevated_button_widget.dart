import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget(
      {super.key, this.onPressed, required this.widget, this.buttonStyle});

  final void Function()? onPressed;
  final Widget widget;
  final ButtonStyle? buttonStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: widget,
    );
  }
}
