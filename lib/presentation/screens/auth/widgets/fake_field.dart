import 'package:flutter/material.dart';

class FakeField extends StatelessWidget {
  const FakeField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0,
      height: 0,
      child: TextFormField(
        controller: controller,
      ),
    );
  }
}
