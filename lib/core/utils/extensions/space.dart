import 'package:flutter/material.dart';

extension SpaceExtension on num {
  SizedBox space() {
    return SizedBox(
      width: toDouble(),
      height: toDouble(),
    );
  }
}
