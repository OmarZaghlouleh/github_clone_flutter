import 'package:flutter/material.dart';

import 'global.dart';

class AppRouter {
  static Future<dynamic> navigateTo({
    required BuildContext context,
    required Widget destination,
  }) {
    return Navigator.of(context).push<Object>(MaterialPageRoute(
      builder: (context) => destination,
    ));
  }

  static Future<dynamic> navigateRemoveTo({
    required BuildContext context,
    required Widget destination,
  }) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => destination), (route) => false);
  }

  static Future<dynamic> navigateReplacementTo({
    required BuildContext context,
    required Widget destination,
  }) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  static navigateBackByGlobalNavigatorKey(dynamic data) {
    navigatorKey.currentState?.pop(data);
  }

  static navigateByGlobalNavigatorKey(
    Widget classToNavigate,
  ) {
    navigatorKey.currentState?.push(PageRouteBuilder<Object>(
      pageBuilder:
          (BuildContext c, Animation<double> a1, Animation<double> a2) =>
              classToNavigate,
      maintainState: true,
      barrierDismissible: true,
      opaque: true,
      transitionsBuilder: (BuildContext c, Animation<double> anim,
              Animation<double> a2, Widget child) =>
          FadeTransition(opacity: anim, child: child),
      transitionDuration: const Duration(milliseconds: 0),
    ));
  }
}
