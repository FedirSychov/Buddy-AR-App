import 'package:shared_preferences/shared_preferences.dart';

import '../model/plantType.dart';

class SharedPrefs {
  static SharedPreferences? sharedPrefs;

  final String IS_RETURNING_USER = "isReturningUser";

  final String PLANT_TYPE = "plantType";
  final String PLANT_PROGRESS = "plantProgress";

  final String SESSION_DURATION = "sessionDuration";
  final String BREAK_DURATION = "breakDuration";

  final String SELECTED_SESSION_DURATION = "selectedSessionDuration";
  final String SELECTED_BREAK_DURATION = "selectedBreakDuration";

  init() async {
    sharedPrefs ??= await SharedPreferences.getInstance();
  }

  void setIsReturningUser(bool isReturningUser) async {
    await sharedPrefs?.setBool(IS_RETURNING_USER, isReturningUser);
  }

  bool getReturningUser() {
    return sharedPrefs?.getBool(IS_RETURNING_USER) ?? false;
  }

  void setPlantType(PlantType plantType) async {
    await sharedPrefs?.setInt(PLANT_TYPE, plantType.index);
  }

  int? getPlantType() {
    return sharedPrefs?.getInt(PLANT_TYPE);
  }

  Future<bool> incPlantProgress() async {
    bool hasGrown = false;
    if (getPlantProgress() < 2) {
      // Maximum progress of plants
      await sharedPrefs?.setInt(PLANT_PROGRESS, getPlantProgress() + 1);
      hasGrown = true;
    }
    return hasGrown;
  }

  int getPlantProgress() {
    return sharedPrefs?.getInt(PLANT_PROGRESS) ?? 0;
  }

  void deletePlantType() {
    sharedPrefs?.remove(PLANT_TYPE);
  }

  /// set the remaining session duration [secs]
  void setSessionDuration(int duration) async {
    await sharedPrefs?.setInt(SESSION_DURATION, duration);
  }

  /// get the remaining session duration in seconds
  int getSessionDuration() {
    return sharedPrefs?.getInt(SESSION_DURATION) ?? 1800;
  }

  /// set the remaining break duration [secs]
  void setBreakDuration(int duration) async {
    await sharedPrefs?.setInt(BREAK_DURATION, duration);
  }

  /// get the remaining break duration in seconds
  int getBreakDuration() {
    return sharedPrefs?.getInt(BREAK_DURATION) ?? 900;
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
