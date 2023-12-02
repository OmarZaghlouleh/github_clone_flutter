import 'package:fluttertoast/fluttertoast.dart';

import '../style/app_colors.dart';

Future<bool?> showToastWidget(String message) {
  return Fluttertoast.showToast(
      webPosition: "center",
      webBgColor: "linear-gradient(to right, #417D9FFF, #417D9FFF, #417D9FFF)",
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      textColor: AppColors.thirdColor,
      fontSize: 16.0);
}