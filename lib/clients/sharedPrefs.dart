import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? sharedPrefs;

  final String IS_RETURNING_USER = "isReturningUser";

  init() async {
    if (sharedPrefs == null) {
      sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  void setIsReturningUser(bool isReturningUser) async {
    await sharedPrefs?.setBool(IS_RETURNING_USER, isReturningUser);
  }

  bool? getReturningUser() {
    return sharedPrefs?.getBool(IS_RETURNING_USER);
  }

}