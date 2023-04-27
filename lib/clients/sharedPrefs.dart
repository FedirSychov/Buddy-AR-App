import 'package:shared_preferences/shared_preferences.dart';

import '../model/plantType.dart';

class SharedPrefs {
  static SharedPreferences? sharedPrefs;

  final String IS_RETURNING_USER = "isReturningUser";

  final String SESSION_HOURS = "sessionHours";
  final String SESSION_MINS = "sessionMins";
  final String SESSION_SECS = "sessionSecs";

  final String BREAK_HOURS = "breakHours";
  final String BREAK_MINS = "breakMins";
  final String BREAK_SECS = "breakSecs";

  final String PLANT_TYPE = "plantType";

  final String SELECTED_SESSION_DURATION = "selectedSessionDuration";
  final String SELECTED_BREAK_DURATION = "selectedBreakDuration";

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

  void setSessionHoursDuration(int hours) async {
    await sharedPrefs?.setInt(SESSION_HOURS, hours);
  }

  void setSessionMinsDuration(int mins) async {
    await sharedPrefs?.setInt(SESSION_MINS, mins);
  }

  void setSessionSecsDuration(int secs) async {
    await sharedPrefs?.setInt(SESSION_SECS, secs);
  }

  int? getSessionHourDuration() {
    return sharedPrefs?.getInt(SESSION_HOURS);
  }

  int? getSessionMinsDuration() {
    return sharedPrefs?.getInt(SESSION_MINS);
  }

  int? getSessionSecsDuration() {
    return sharedPrefs?.getInt(SESSION_SECS);
  }

  void setBreakHoursDuration(int hours) async {
    await sharedPrefs?.setInt(BREAK_HOURS, hours);
  }

  void setBreakMinsDuration(int mins) async {
    await sharedPrefs?.setInt(BREAK_MINS, mins);
  }

  void setBreakSecsDuration(int secs) async {
    await sharedPrefs?.setInt(BREAK_SECS, secs);
  }

  int? getBreakHourDuration() {
    return sharedPrefs?.getInt(BREAK_HOURS);
  }

  int? getBreakMinsDuration() {
    return sharedPrefs?.getInt(BREAK_MINS);
  }

  int? getBreakSecsDuration() {
    return sharedPrefs?.getInt(BREAK_SECS);
  }

  void setPlantType(PlantType plantType) async {
    await sharedPrefs?.setInt(PLANT_TYPE, plantType.index);
  }

  int? getPlantType() {
    return sharedPrefs?.getInt(PLANT_TYPE);
  }

  void setSelectedSessionDuration(String sessionDuration) async {
    await sharedPrefs?.setString(SELECTED_SESSION_DURATION, sessionDuration);
  }

  String? getSelectedSessionDuration() {
    return sharedPrefs?.getString(SELECTED_SESSION_DURATION);
  }

  void setSelectedBreakDuration(String breakDuration) async {
    await sharedPrefs?.setString(SELECTED_BREAK_DURATION, breakDuration);
  }

  String? getSelectedBreakDuration() {
    return sharedPrefs?.getString(SELECTED_BREAK_DURATION);
  }
}
