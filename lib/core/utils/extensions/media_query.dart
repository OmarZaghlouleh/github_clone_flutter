//MediaQuery
import 'package:flutter/material.dart';

extension MediaQueryExtension on num {
  double mqWidth(BuildContext context, {bool aspect = false}) => aspect
      ? MediaQuery.of(context).size.width *
          this *
          MediaQuery.of(context).size.aspectRatio
      : MediaQuery.of(context).size.width * this;
  double mqHeight(
    BuildContext context, {
    bool aspect = false,
  }) =>
      aspect
          ? MediaQuery.of(context).size.height *
              this *
              MediaQuery.of(context).size.aspectRatio
          : MediaQuery.of(context).size.height * this;
}
