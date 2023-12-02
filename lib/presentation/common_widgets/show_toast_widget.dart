import 'package:fluttertoast/fluttertoast.dart';

import '../style/app_colors.dart';

Future<bool?> showToastWidget(String message) {
  return Fluttertoast.showToast(
      webPosition: "center",
      webBgColor: "linear-gradient(to right, #ff0000, #ff0000, #ff0000)",
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      textColor: AppColors.primaryColor,
      fontSize: 16.0);
}