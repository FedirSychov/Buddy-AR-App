import '../clients/sharedPrefs.dart';

class SetupSessionViewModel {
  SharedPrefs sharedPrefs = SharedPrefs();
  final basicStudyDuration = "1 hour";
  final basicBreakDuration = "10 mins";

  SetupSessionViewModel() {
    sharedPrefs = SharedPrefs();
    if (sharedPrefs.getSelectedSessionDuration() == null) {
      saveCurrentStudyTime(basicStudyDuration);
    }
    if (sharedPrefs.getSelectedBreakDuration() == null) {
      saveCurrentBreakTime(basicBreakDuration);
    }
  }

  List<int> translateSessionTimeIntoIntArray(String sessionTime) {
    List<int> outputArray;
    switch (sessionTime) {
      case "30 mins":
        {
          outputArray = [0, 30, 0];
          break;
        }
      case "1 hour":
        {
          outputArray = [1, 0, 0];
          break;
        }
      case "1,5 hours":
        {
          outputArray = [1, 30, 0];
          break;
        }
      case "2 hours":
        {
          outputArray = [2, 0, 0];
          break;
        }
      default:
        {
          outputArray = [1, 0, 0];
          break;
        }
    }
    return outputArray;
  }

  List<int> translateBreakTimeIntoIntArray(String breakTime) {
    List<int> outputArray;
    switch (breakTime) {
      case "15 mins":
        {
          outputArray = [0, 15, 0];
          break;
        }
      case "30 mins":
        {
          outputArray = [0, 30, 0];
          break;
        }
      case "45 mins":
        {
          outputArray = [0, 45, 0];
          break;
        }
      case "1 hour":
        {
          outputArray = [1, 0, 0];
          break;
        }
      default:
        {
          outputArray = [0, 15, 0];
          break;
        }
    }
    return outputArray;
  }

  void saveCurrentStudyTime(String selectedDuration) {
    List<int> studyTime = translateSessionTimeIntoIntArray(selectedDuration);
    sharedPrefs.setSessionHoursDuration(studyTime[0]);
    sharedPrefs.setSessionMinsDuration(studyTime[1]);
    sharedPrefs.setSessionSecsDuration(studyTime[2]);
    sharedPrefs.setSelectedSessionDuration(selectedDuration);
  }

  void saveCurrentBreakTime(String selectedDuration) {
    List<int> breakTime = translateBreakTimeIntoIntArray(selectedDuration);
    sharedPrefs.setBreakSecsDuration(breakTime[0]);
    sharedPrefs.setBreakMinsDuration(breakTime[1]);
    sharedPrefs.setBreakHoursDuration(breakTime[2]);
    sharedPrefs.setSelectedBreakDuration(selectedDuration);
  }

  String getCurrentStudyTime() {
    return sharedPrefs.getSelectedSessionDuration() ?? basicStudyDuration;
  }

  String getCurrentBreakTime() {
    return sharedPrefs.getSelectedBreakDuration() ?? basicBreakDuration;
  }
}
