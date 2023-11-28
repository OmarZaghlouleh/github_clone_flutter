import 'package:shared_preferences/shared_preferences.dart';

class LocalResource {
  static late SharedPreferences sharedPreferences;

  static Future<void> initLocalResource() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
