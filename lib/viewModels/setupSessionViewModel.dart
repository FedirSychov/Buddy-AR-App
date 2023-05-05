<<<<<<< HEAD
import 'package:flutter/material.dart';

import '../clients/sharedPrefs.dart';

class SetupSessionViewModel {
  final sharedPrefs = SharedPrefs();
  final basicStudyDuration = "1 hour";
  final basicBreakDuration = "10 mins";

  void saveCurrentStudyTime(String selectedDuration) {
    sharedPrefs.setSelectedSessionDuration(selectedDuration);
  }

  void saveCurrentBreakTime(String selectedDuration) {
    sharedPrefs.setSelectedBreakDuration(selectedDuration);
  }

  String getCurrentStudyTime() {
    return sharedPrefs.getSelectedSessionDuration() ?? basicStudyDuration;
  }

  String getCurrentBreakTime() {
    return sharedPrefs.getSelectedBreakDuration() ?? basicBreakDuration;
  }
}
=======

>>>>>>> 66c31bf4fd7952ee31b52259cb493dfd0953d18c
